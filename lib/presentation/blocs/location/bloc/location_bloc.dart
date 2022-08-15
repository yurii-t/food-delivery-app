import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/data/datasource/firebase_remote_datasource_impl.dart';
import 'package:food_delivery_app/data/datasource/places_datasource_impl.dart';
import 'package:food_delivery_app/data/models/place.dart';
import 'package:food_delivery_app/data/models/restaurant.dart';
import 'package:food_delivery_app/data/models/restaurant_category.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final FirebaseRemoteDataSourceImpl firebaseRemoteDataSourceImpl;
  final PlacesDatasourceImpl placesDatasourceImpl;
  Location location = Location();
  LocationData? locationData;
  PermissionStatus? _permissionGranted;

  // ignore: long-method
  LocationBloc({
    required this.firebaseRemoteDataSourceImpl,
    required this.placesDatasourceImpl,
  }) : super(LocationInitial()) {
    List<Restaurant> initRestaurantsList = [];

    on<PermissionRequest>((event, emit) async {
      _permissionGranted = await location.requestPermission();
      add(const LoadMap());
    });
    on<LoadMap>((event, emit) async {
      Place place = const Place(lat: 0, lon: 0);
      final restaurants = await firebaseRemoteDataSourceImpl.getRestaurants();
      final restaurantsCategories =
          await firebaseRemoteDataSourceImpl.getRestaurantCategories();
      initRestaurantsList = restaurants;
      _permissionGranted = await location.hasPermission();

      if (_permissionGranted == PermissionStatus.denied) {
        emit(LocationPermissionDenied());
      }

      if (_permissionGranted == PermissionStatus.deniedForever) {
        emit(
          LocationLoaded(
            place: place,
            controller: event.controller,
            restaurants: restaurants,
            restaurantCategories: restaurantsCategories,
          ),
        );
      }

      if (_permissionGranted == PermissionStatus.granted) {
        locationData = await location.getLocation();
        place = Place(
          lat: locationData?.latitude ?? 37.4868,
          lon: locationData?.longitude ?? -122.2119,
        );

        emit(
          LocationLoaded(
            place: place,
            controller: event.controller,
            restaurants: restaurants,
            restaurantCategories: restaurantsCategories,
            locationData: locationData,
          ),
        );
      }
    });
    on<SearchLocation>((event, emit) async {
      final state = this.state as LocationLoaded;
      final Place place = await placesDatasourceImpl.getPlace(event.placeId);

      await state.controller?.animateCamera(
        CameraUpdate.newLatLngZoom(LatLng(place.lat, place.lon), 20),
      );

      final restaurants = await firebaseRemoteDataSourceImpl.getRestaurants();
      emit(
        LocationLoaded(
          place: place,
          controller: state.controller,
          restaurants: restaurants,
          restaurantCategories: state.restaurantCategories,
          locationData: locationData,
        ),
      );
    });

    on<SearchLocationFromFirebase>((event, emit) async {
      final state = this.state as LocationLoaded;

      await state.controller?.animateCamera(
        CameraUpdate.newLatLngZoom(event.location, 20),
      );
      final Place place =
          Place(lat: event.location.latitude, lon: event.location.longitude);

      final restaurants = await firebaseRemoteDataSourceImpl.getRestaurants();
      emit(
        LocationLoaded(
          place: place,
          controller: state.controller,
          restaurants: restaurants,
          restaurantCategories: state.restaurantCategories,
          locationData: locationData,
        ),
      );
    });

    on<SelectMarkerRestaurant>((event, emit) async {
      final state = this.state as LocationLoaded;

      final restaurants = List<Restaurant>.from(state.restaurants);

      emit(
        LocationLoaded(
          place: state.place,
          controller: state.controller,
          restaurants: restaurants,
          selectedRestaurant: event.selectedRestaurant,
          restaurantCategories: state.restaurantCategories,
          locationData: locationData,
        ),
      );
    });

    on<SelectRestaurantsCategory>((event, emit) async {
      final state = this.state as LocationLoaded;

      if (event.selectedRestaurantCategory.categoryName.isEmpty) {
        emit(
          LocationLoaded(
            place: state.place,
            controller: state.controller,
            restaurants: initRestaurantsList,
            restaurantCategories: state.restaurantCategories,
            locationData: locationData,
          ),
        );
      } else {
        final selcetedItems = initRestaurantsList
            .where((items) =>
                items.category == event.selectedRestaurantCategory.categoryName)
            .toList();

        emit(
          LocationLoaded(
            place: state.place,
            controller: state.controller,
            restaurants: selcetedItems,
            restaurantCategories: state.restaurantCategories,
            selectedCategory: event.selectedRestaurantCategory,
            locationData: locationData,
          ),
        );
      }
    });
  }
}
