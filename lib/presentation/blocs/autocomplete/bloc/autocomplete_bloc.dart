import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/data/datasource/places_datasource_impl.dart';
import 'package:food_delivery_app/data/models/place_autocomplete.dart';

part 'autocomplete_event.dart';
part 'autocomplete_state.dart';

class AutocompleteBloc extends Bloc<AutocompleteEvent, AutocompleteState> {
  final PlacesDatasourceImpl placesDatasourceImpl;
  AutocompleteBloc(this.placesDatasourceImpl) : super(AutocompleteInitial()) {
    on<LoadAutocomplete>((event, emit) async {
      final List<PlaceAutocomplete> autocomplete =
          await placesDatasourceImpl.getAutocomplete(event.searchInput);

      emit(AutocompleteLoaded(autocomplete: autocomplete));
    });

    on<ClearAutocomplete>((event, emit) {
      emit(AutocompleteLoaded(autocomplete: List.empty()));
    });
  }
}
