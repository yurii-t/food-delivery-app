import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class RestaurantCategory extends Equatable {
  final String categoryName;
  final String categoryNameIcon;
  final String? image;

  const RestaurantCategory({
    required this.categoryName,
    required this.categoryNameIcon,
    this.image,
  });

  factory RestaurantCategory.fromSnapShot(DocumentSnapshot snap) {
    final RestaurantCategory category = RestaurantCategory(
      categoryName: snap['categoryName'] as String,
      categoryNameIcon: snap['categoryNameIcon'] as String,
      image: snap['image'] as String,
    );

    return category;
  }

  @override
  List<Object?> get props => [categoryName, categoryNameIcon, image];
}
