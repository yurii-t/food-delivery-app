part of 'bottombar_bloc.dart';

abstract class BottombarState extends Equatable {
  const BottombarState();

  @override
  List<Object> get props => [];
}

class BottombarInitial extends BottombarState {}

class BottombarLoaded extends BottombarState {
  final bool hide;

  const BottombarLoaded({this.hide = false});
  @override
  List<Object> get props => [hide];
}
