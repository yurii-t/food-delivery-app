part of 'menu_bloc.dart';

abstract class MenuState extends Equatable {
  const MenuState();

  @override
  List<Object> get props => [];
}

class MenuInitial extends MenuState {}

class MenuLoading extends MenuState {}

class MenuLoaded extends MenuState {
  final List<Menu> menuItems;
  final List<MenuCategory> categoryList;
  final MenuCategory? selectedCategory;

  const MenuLoaded({
    required this.categoryList,
    this.menuItems = const <Menu>[],
    this.selectedCategory,
  });

  @override
  List<Object> get props => [menuItems, categoryList];
}
