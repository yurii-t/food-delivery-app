import 'package:food_delivery_app/data/models/place.dart';
import 'package:food_delivery_app/data/models/place_autocomplete.dart';

abstract class PlacesDatasource {
  Future<List<PlaceAutocomplete>?> getAutocomplete(String searchInput);
  Future<Place?> getPlace(String placeId);
}
