part of 'bottombar_bloc.dart';

abstract class BottombarEvent extends Equatable {
  const BottombarEvent();

  @override
  List<Object> get props => [];
}

class LoadBottomBar extends BottombarEvent {}

class HideBottomBar extends BottombarEvent {
  final bool hide;

  const HideBottomBar({this.hide = false});
  @override
  List<Object> get props => [hide];
}
