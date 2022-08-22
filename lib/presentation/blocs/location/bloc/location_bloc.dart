import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/data/datasource/firebase_remote_datasource_impl.dart';
import 'package:food_delivery_app/data/datasource/places_datasource_impl.dart';
import 'package:food_delivery_app/data/models/place.dart';
import 'package:food_delivery_app/data/models/restaurant.dart';
import 'package:food_delivery_app/data/models/restaurant_category.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';

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
    final restaurants = firebaseRemoteDataSourceImpl.getRestaurantsStream();
    on<PermissionRequest>((event, emit) async {
      _permissionGranted = await location.requestPermission();
      add(const LoadMap());
    });
    on<LoadMap>(
      (event, emit) async {
        Place place = const Place(lat: 0, lon: 0);

        final restaurantsCategories =
            await firebaseRemoteDataSourceImpl.getRestaurantCategories();

        _permissionGranted = await location.hasPermission();

        if (_permissionGranted == PermissionStatus.denied) {
          emit(LocationPermissionDenied());
        }

        if (_permissionGranted == PermissionStatus.deniedForever) {
          emit(
            LocationLoaded(
              place: place,
              controller: event.controller,
              restaurants: await restaurants.first,
              restaurantCategories: restaurantsCategories,
            ),
          );
        }

        if (_permissionGranted == PermissionStatus.granted) {
          final streamUserLocation = location.onLocationChanged;

          place = Place(
            lat: locationData?.latitude ?? 37.4868,
            lon: locationData?.longitude ?? -122.2119,
          );

          var testStream = Rx.combineLatest2(
            streamUserLocation,
            restaurants,
            (location, restaurants) {
              return CombinedLocationDataRestaurants(
                restaurants as List<Restaurant>,
                location as LocationData,
              );
            },
          );

          await emit.forEach(
            testStream,
            onData: (CombinedLocationDataRestaurants data) {
              final state = this.state;

              return state is LocationLoaded
                  ? state.copyWith(
                      locationData: data.locationData,
                      selectedRestaurant: state.selectedRestaurant,
                      controller: event.controller,
                    )
                  : LocationLoaded(
                      place: place,
                      controller: event.controller,
                      restaurants: data.restaurants,
                      restaurantCategories: restaurantsCategories,
                      locationData: data.locationData,
                    );
            },
          );
        }
      },
      transformer: restartable(),
    );
    on<SearchLocation>((event, emit) async {
      final state = this.state as LocationLoaded;
      final Place place = await placesDatasourceImpl.getPlace(event.placeId);

      await state.controller?.animateCamera(
        CameraUpdate.newLatLngZoom(LatLng(place.lat, place.lon), 20),
      );

      final restaurantsFirebase =
          await firebaseRemoteDataSourceImpl.getRestaurantsStream();
      emit(
        state.copyWith(
          restaurants: await restaurantsFirebase.first,
          place: place,
          selectedCategory: const RestaurantCategory(
            categoryName: '',
            categoryNameIcon: '',
          ),
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

      final restaurantsFirebase =
          await firebaseRemoteDataSourceImpl.getRestaurantsStream();
      emit(
        state.copyWith(
          restaurants: await restaurantsFirebase.first,
          place: place,
          selectedCategory: const RestaurantCategory(
            categoryName: '',
            categoryNameIcon: '',
          ),
        ),
      );
    });

    on<SelectMarkerRestaurant>((event, emit) async {
      final state = this.state as LocationLoaded;

      emit(
        state.copyWith(
          selectedRestaurant: event.selectedRestaurant,
        ),
      );
    });

    on<SelectRestaurantsCategory>((event, emit) async {
      final state = this.state as LocationLoaded;
      final testrestaurants =
          await firebaseRemoteDataSourceImpl.getRestaurantsStream();

      if (event.selectedRestaurantCategory.categoryName.isEmpty) {
        emit(state.copyWith(
          restaurants: await testrestaurants.first,
          selectedCategory: event.selectedRestaurantCategory,
        ));
      } else {
        final tmp = await testrestaurants.first;

        final items = tmp
            .where((element) =>
                element.category ==
                event.selectedRestaurantCategory.categoryName)
            .toList();
        print(items);
        emit(state.copyWith(
          restaurants: items,
          selectedCategory: event.selectedRestaurantCategory,
        ));
      }
    });

    on<CentralizedCamera>((event, emit) async {
      final state = this.state as LocationLoaded;

      //////  0,00000301748517 ///////
      final screenParam = await state.controller!
          .getScreenCoordinate(LatLng(event.lat, event.lon));

      await state.controller
          ?.animateCamera(CameraUpdate.scrollBy(0, screenParam.y / 4.5));
    });
  }
}

class CombinedLocationDataRestaurants {
  final List<Restaurant> restaurants;
  final LocationData locationData;

  CombinedLocationDataRestaurants(this.restaurants, this.locationData);
}
