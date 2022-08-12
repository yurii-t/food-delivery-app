part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class LoadFavorites extends FavoritesEvent {}

class AddFavorites extends FavoritesEvent {
  final Restaurant restaurant;

  const AddFavorites({required this.restaurant});
  @override
  List<Object> get props => [restaurant];
}
