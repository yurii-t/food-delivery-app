import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';

part 'bottombar_event.dart';
part 'bottombar_state.dart';

class BottombarBloc extends Bloc<BottombarEvent, BottombarState> {
  BottombarBloc() : super(BottombarInitial()) {
    on<LoadBottomBar>(
      (event, emit) {
        emit(const BottombarLoaded());
      },
    );
    on<HideBottomBar>(
      (event, emit) {
        emit(BottombarLoaded(hide: event.hide));
      },
    );
  }
}
