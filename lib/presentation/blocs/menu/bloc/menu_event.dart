part of 'menu_bloc.dart';

abstract class MenuEvent extends Equatable {
  const MenuEvent();

  @override
  List<Object> get props => [];
}

class LoadMenu extends MenuEvent {
  final String restaurantId;

  const LoadMenu(this.restaurantId);
  @override
  List<Object> get props => [restaurantId];
}

class SelectMenuCategory extends MenuEvent {
  final MenuCategory selectedCategory;

  const SelectMenuCategory(this.selectedCategory);
}
