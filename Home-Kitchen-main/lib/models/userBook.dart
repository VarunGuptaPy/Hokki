import 'package:flutter/material.dart';

class UserBook {
  List daysBetween;
  List daysNotWanted;
  List daysWanted;
  String endDate;
  String id;
  double price;
  String sellerAddress;
  double sellerLat;
  String sellerName;
  String sellerPhoneNumber;
  String sellerUID;
  double sellerlng;
  String startDate;
  int addonsPrice;
  int foodPrice;
  String sellerPhoto;
  UserBook({
    required this.sellerPhoto,
    required this.daysBetween,
    required this.daysNotWanted,
    required this.daysWanted,
    required this.endDate,
    required this.id,
    required this.price,
    required this.sellerAddress,
    required this.sellerLat,
    required this.sellerName,
    required this.sellerPhoneNumber,
    required this.sellerUID,
    required this.sellerlng,
    required this.startDate,
    required this.addonsPrice,
    required this.foodPrice,
  });
  static UserBook fromMap(Map<String, dynamic> map) => UserBook(
      sellerPhoto: map['sellerPhoto'],
      addonsPrice: map['addonsPrice'],
      foodPrice: map['foodPrice'],
      daysBetween: map['daysBetween'],
      daysNotWanted: map['daysNotWanted'],
      daysWanted: map['daysWanted'],
      endDate: map['endDate'],
      id: map['id'],
      price: map['price'],
      sellerAddress: map['sellerAddress'],
      sellerLat: map['sellerLat'],
      sellerName: map['sellerName'],
      sellerPhoneNumber: map['sellerPhoneNumber'],
      sellerUID: map['sellerUID'],
      sellerlng: map['sellerlng'],
      startDate: map['startDate']);
}
