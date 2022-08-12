part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object?> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final Place place;
  final GoogleMapController? controller;
  final List<Restaurant> restaurants;
  final Restaurant? selectedRestaurant;
  final List<RestaurantCategory> restaurantCategories;
  final RestaurantCategory? selectedCategory;
  final LocationData? locationData;

  const LocationLoaded({
    required this.place,
    required this.restaurants,
    required this.restaurantCategories,
    this.controller,
    this.selectedRestaurant,
    this.selectedCategory,
    this.locationData,
  });

  @override
  List<Object?> get props =>
      [controller, place, restaurants, selectedRestaurant, selectedCategory];

  LocationLoaded copyWith({
    Place? place,
    GoogleMapController? controller,
    List<Restaurant>? restaurants,
    Restaurant? selectedRestaurant,
    List<RestaurantCategory>? restaurantCategories,
    RestaurantCategory? selectedCategory,
    LocationData? locationData,
  }) {
    return LocationLoaded(
      place: place ?? this.place,
      controller: controller ?? this.controller,
      restaurants: restaurants ?? this.restaurants,
      selectedRestaurant: selectedRestaurant ?? this.selectedRestaurant,
      restaurantCategories: restaurantCategories ?? this.restaurantCategories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      locationData: locationData ?? this.locationData,
    );
  }
}

class LocationPermissionDenied extends LocationState {}
