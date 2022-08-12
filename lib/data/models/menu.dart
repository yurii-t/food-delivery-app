import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Menu extends Equatable {
  final String dishName;
  final String dishImage;
  final String dishIngredients;
  final String dishCategory;
  final num dishPrice;
  final num calories;
  final num weight;

  const Menu({
    required this.dishName,
    required this.dishImage,
    required this.dishIngredients,
    required this.dishCategory,
    required this.dishPrice,
    required this.calories,
    required this.weight,
  });

  factory Menu.fromSnapShot(DocumentSnapshot snap) {
    final Menu menu = Menu(
      dishName: snap['dishName'] as String,
      dishImage: snap['dishImage'] as String,
      dishIngredients: snap['dishIngredients'] as String,
      dishCategory: snap['dishCategory'] as String,
      dishPrice: snap['dishPrice'] as num,
      calories: snap['calories'] as num,
      weight: snap['weight'] as num,
    );

    return menu;
  }

  factory Menu.mapfromSnapShot(Map<String, dynamic> snap) {
    final Menu menuMap = Menu(
      dishName: snap['dishName'] as String,
      dishImage: snap['dishImage'] as String,
      dishIngredients: snap['dishIngredients'] as String,
      dishCategory: snap['dishCategory'] as String,
      dishPrice: snap['dishPrice'] as num,
      calories: snap['calories'] as num,
      weight: snap['weight'] as num,
    );

    return menuMap;
  }
  Map<String, Object> toDocument() {
    return {
      'dishName': dishName,
      'dishImage': dishImage,
      'dishIngredients': dishIngredients,
      'dishCategory': dishCategory,
      'dishPrice': dishPrice,
      'calories': calories,
      'weight': weight,
    };
  }

  @override
  List<Object?> get props => [
        dishName,
        dishImage,
        dishIngredients,
        dishCategory,
        dishPrice,
        calories,
        weight,
      ];
}
