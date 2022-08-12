import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:food_delivery_app/data/datasource/places_datasource.dart';
import 'package:food_delivery_app/data/models/place.dart';
import 'package:food_delivery_app/data/models/place_autocomplete.dart';
import 'package:http/http.dart' as http;

class PlacesDatasourceImpl implements PlacesDatasource {
  final String key = dotenv.get('MAPS_API');
  // String g = dotenv.env['MAPS_API']!;
  // final String types = 'geocode';
  final String types = 'establishment';

  @override
  Future<List<PlaceAutocomplete>> getAutocomplete(String searchInput) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$searchInput&types=$types&key=$key';

    final response = await http.get(Uri.parse(url));
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final results = json['predictions'] as List;

    return results
        .map((dynamic e) =>
            PlaceAutocomplete.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<Place> getPlace(String placeId) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';

    final response = await http.get(Uri.parse(url));
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    ;
    final results = json['result'] as Map<String, dynamic>;

    return Place.fromJson(results);
  }
}
