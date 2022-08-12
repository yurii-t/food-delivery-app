class PlaceAutocomplete {
  final String description;
  final String placeId;

  PlaceAutocomplete({required this.description, required this.placeId});

  factory PlaceAutocomplete.fromJson(Map<String, dynamic> json) {
    return PlaceAutocomplete(
      description: json['description'] as String,
      placeId: json['place_id'] as String,
    );
  }
}
