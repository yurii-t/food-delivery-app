part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class CreateCurrentUser extends UserEvent {
  final String name;

  final String email;

  const CreateCurrentUser(
    this.name,
    this.email,
  );

  @override
  List<Object> get props => [
        name,
        email,
      ];
}

class LoadUserInfo extends UserEvent {}

class UpdateUserInfo extends UserEvent {
  final String name;
  final String email;

  const UpdateUserInfo(this.name, this.email);
  @override
  List<Object> get props => [
        name,
        email,
      ];
}

class UpdateMainCard extends UserEvent {
  final String cardNumber;

  const UpdateMainCard(
    this.cardNumber,
  );
  @override
  List<Object> get props => [
        cardNumber,
      ];
}

class AddCard extends UserEvent {
  final PaymentMethod card;

  const AddCard(
    this.card,
  );
  @override
  List<Object> get props => [
        card,
      ];
}

class RemoveCard extends UserEvent {
  final PaymentMethod card;

  const RemoveCard(
    this.card,
  );
  @override
  List<Object> get props => [
        card,
      ];
}

class SendSupportMessage extends UserEvent {
  final String email;
  final String message;

  const SendSupportMessage(
    this.email,
    this.message,
  );
  @override
  List<Object> get props => [
        email,
        message,
      ];
}
