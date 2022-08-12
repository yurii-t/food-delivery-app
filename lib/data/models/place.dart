import 'package:equatable/equatable.dart';

class Place extends Equatable {
  final String placeId;

  final String name;

  final double lat;

  final double lon;

  const Place({
    required this.lat,
    required this.lon,
    this.placeId = '',
    this.name = '',
  });
  factory Place.fromJson(Map<String, dynamic> json) {
    return json.keys.contains('place_id')
        ? Place(
            placeId: json['place_id'] as String,
            name: json['name'] as String,
            lat: json['geometry']['location']['lat'] as double,
            lon: json['geometry']['location']['lng'] as double,
          )
        : Place(
            placeId: json['placeId'] as String,
            name: json['name'] as String,
            lat: json['lat'] as double,
            lon: json['lon'] as double,
          );
  }

  @override
  List<Object?> get props => [placeId, name, lat, lon];
}
