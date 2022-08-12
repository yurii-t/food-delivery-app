part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object?> get props => [];
}

class PermissionRequest extends LocationEvent {}

class LoadMap extends LocationEvent {
  final GoogleMapController? controller;

  const LoadMap({this.controller});

  @override
  List<Object?> get props => [controller];
}

class SearchLocation extends LocationEvent {
  final String placeId;

  const SearchLocation({required this.placeId});

  @override
  List<Object> get props => [placeId];
}

class SearchLocationFromFirebase extends LocationEvent {
  final LatLng location;

  const SearchLocationFromFirebase({required this.location});

  @override
  List<Object> get props => [location];
}

class SelectMarkerRestaurant extends LocationEvent {
  final Restaurant? selectedRestaurant;

  const SelectMarkerRestaurant(this.selectedRestaurant);
  @override
  List<Object?> get props => [selectedRestaurant];
}

class SelectRestaurantsCategory extends LocationEvent {
  final RestaurantCategory selectedRestaurantCategory;

  const SelectRestaurantsCategory(this.selectedRestaurantCategory);
  @override
  List<Object> get props => [selectedRestaurantCategory];
}
