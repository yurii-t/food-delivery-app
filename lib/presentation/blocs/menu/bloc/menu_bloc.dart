import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/data/datasource/firebase_remote_datasource_impl.dart';
import 'package:food_delivery_app/data/models/menu.dart';
import 'package:food_delivery_app/data/models/menu_category.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final FirebaseRemoteDataSourceImpl firebaseRemoteDataSourceImpl;
  MenuBloc(this.firebaseRemoteDataSourceImpl) : super(MenuInitial()) {
    List<Menu> initMenuList = [];
    on<LoadMenu>((event, emit) async {
      final menuItems =
          await firebaseRemoteDataSourceImpl.getMenu(event.restaurantId);
      final categoryList =
          await firebaseRemoteDataSourceImpl.getMenuCategories();
      initMenuList = menuItems;

      emit(MenuLoaded(menuItems: menuItems, categoryList: categoryList));
    });

    on<SelectMenuCategory>((event, emit) async {
      final state = this.state;
      if (state is MenuLoaded) {
        if (event.selectedCategory.categories.isEmpty) {
          emit(MenuLoaded(
            menuItems: initMenuList,
            categoryList: state.categoryList,
            selectedCategory: event.selectedCategory,
          ));
        } else {
          final selcetedItems = initMenuList
              .where((items) =>
                  items.dishCategory == event.selectedCategory.categories)
              .toList();

          emit(MenuLoaded(
            menuItems: selcetedItems,
            categoryList: state.categoryList,
            selectedCategory: event.selectedCategory,
          ));
        }
      }
    });
  }
}
