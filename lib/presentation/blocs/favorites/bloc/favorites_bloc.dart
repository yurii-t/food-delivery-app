import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/data/datasource/firebase_remote_datasource_impl.dart';
import 'package:food_delivery_app/data/models/restaurant.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FirebaseRemoteDataSourceImpl firebaseRemoteDataSourceImpl;
  FavoritesBloc(this.firebaseRemoteDataSourceImpl) : super(FavoritesInitial()) {
    on<LoadFavorites>((event, emit) async {
      final restStream = firebaseRemoteDataSourceImpl.getFavorites();
      if (restStream.length == 0) {
        emit(const FavoritesLoaded(restaurants: []));
      } else {
        await emit.forEach(
          firebaseRemoteDataSourceImpl.getFavorites(),
          onData: (restaurants) =>
              FavoritesLoaded(restaurants: restaurants as List<Restaurant>),
        );
      }
    });

    on<AddFavorites>((event, emit) async {
      await firebaseRemoteDataSourceImpl.addToFavorites(event.restaurant);
    });
  }
}
