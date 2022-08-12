part of 'categories_bloc.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final List<RestaurantCategory> categories;
  final List<Restaurant> categoryRestaurants;

  const CategoriesLoaded(this.categories, this.categoryRestaurants);
  @override
  List<Object> get props => [categories, categoryRestaurants];
}
