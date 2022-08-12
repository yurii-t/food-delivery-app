// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class PaymentMethod extends Equatable {
  final String number;
  final String validUntil;
  final String cvv;

  const PaymentMethod({
    required this.number,
    required this.validUntil,
    required this.cvv,
  });

  PaymentMethod copyWith({
    String? number,
    String? validUntil,
    String? cvv,
  }) {
    return PaymentMethod(
      number: number ?? this.number,
      validUntil: validUntil ?? this.validUntil,
      cvv: cvv ?? this.cvv,
    );
  }

  @override
  List<Object> get props => [number, validUntil, cvv];
  Map<String, dynamic> toDocument() {
    return <String, dynamic>{
      'number': number,
      'validUntil': validUntil,
      'cvv': cvv,
    };
  }

  factory PaymentMethod.fromSnapShot(Map<String, dynamic> snap) {
    return PaymentMethod(
      number: snap['number'] as String,
      validUntil: snap['validUntil'] as String,
      cvv: snap['cvv'] as String,
    );
  }
}
