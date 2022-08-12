import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Restaurant extends Equatable {
  final String id;
  final String address;
  final num bookedSeats;
  final String category;
  final String image;
  final GeoPoint location;
  final String name;
  final String options;
  final String orderPrepare;
  final String phoneNumber;
  final num rating;
  final num totalSeats;
  final String webSite;
  final String workingTime;
  final Timestamp openHour;
  final Timestamp closeHour;

  const Restaurant({
    required this.id,
    required this.address,
    required this.bookedSeats,
    required this.category,
    required this.image,
    required this.location,
    required this.name,
    required this.options,
    required this.orderPrepare,
    required this.phoneNumber,
    required this.rating,
    required this.totalSeats,
    required this.webSite,
    required this.workingTime,
    required this.openHour,
    required this.closeHour,
  });

  factory Restaurant.fromSnapShot(DocumentSnapshot snap) {
    final Restaurant restaurant = Restaurant(
      id: snap['id'] as String,
      address: snap['address'] as String,
      bookedSeats: snap['bookedSeats'] as num,
      category: snap['category'] as String,
      image: snap['image'] as String,
      location: snap['location'] as GeoPoint,
      name: snap['name'] as String,
      options: snap['options'] as String,
      orderPrepare: snap['orderPrepare'] as String,
      phoneNumber: snap['phoneNumber'] as String,
      rating: snap['rating'] as num,
      totalSeats: snap['totalSeats'] as num,
      webSite: snap['webSite'] as String,
      workingTime: snap['workingTime'] as String,
      openHour: snap['openHour'] as Timestamp,
      closeHour: snap['closeHour'] as Timestamp,
    );

    return restaurant;
  }
  Map<String, Object> toDocument() {
    return {
      'id': id,
      'address': address,
      'bookedSeats': bookedSeats,
      'category': category,
      'image': image,
      'location': location,
      'name': name,
      'options': options,
      'orderPrepare': orderPrepare,
      'phoneNumber': phoneNumber,
      'rating': rating,
      'totalSeats': totalSeats,
      'webSite': webSite,
      'workingTime': workingTime,
      'openHour': openHour,
      'closeHour': closeHour,
    };
  }

  @override
  List<Object?> get props => [
        id,
        address,
        bookedSeats,
        category,
        image,
        location,
        name,
        options,
        orderPrepare,
        phoneNumber,
        rating,
        totalSeats,
        webSite,
        workingTime,
        openHour,
        closeHour,
      ];
}
