import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/data/datasource/firebase_remote_datasource_impl.dart';
import 'package:food_delivery_app/data/models/restaurant.dart';
import 'package:food_delivery_app/data/models/restaurant_category.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final FirebaseRemoteDataSourceImpl firebaseRemoteDataSourceImpl;
  CategoriesBloc(this.firebaseRemoteDataSourceImpl)
      : super(CategoriesInitial()) {
    on<LoadCategories>((event, emit) async {
      final categoryRestaurants =
          await firebaseRemoteDataSourceImpl.getRestaurants();
      final categories =
          await firebaseRemoteDataSourceImpl.getRestaurantCategories();
      emit(CategoriesLoaded(categories, categoryRestaurants));
    });
  }
}
