import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MenuCategory extends Equatable {
  final String categories;

  const MenuCategory({required this.categories});

  factory MenuCategory.fromSnapShot(DocumentSnapshot snap) {
    final MenuCategory category = MenuCategory(
      categories: snap['categoryName'] as String,
    );

    return category;
  }

  @override
  List<Object?> get props => [categories];
}
