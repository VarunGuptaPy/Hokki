import 'package:flutter/material.dart';

class DriverRequestBook {
  final String id;
  final String userUID;
  final List<dynamic> daysBetween;
  final List<dynamic> dateStage;
  final List<dynamic> daysWanted;
  final List<dynamic> daysNotwanted;
  final String startDate;
  final String endDate;
  final String userAddress;
  final double userLat;
  final double userlng;
  final String userName;
  final String userPhoneNumber;
  final String sellerUID;
  final String sellerName;
  final double sellerLat;
  final double sellerLng;
  final String sellerAddress;
  final String orderType;
  final bool accepted;
  final bool done;
  final String sellerProfilePic;
  final String city;
  final String date;
  final String driverUID;
  final double deliveryPrice;
  final int foodAndAddonPrice;
  DriverRequestBook({
    required this.id,
    required this.userUID,
    required this.daysBetween,
    required this.dateStage,
    required this.daysWanted,
    required this.daysNotwanted,
    required this.startDate,
    required this.endDate,
    required this.userAddress,
    required this.userLat,
    required this.userlng,
    required this.userName,
    required this.userPhoneNumber,
    required this.sellerUID,
    required this.sellerName,
    required this.sellerLat,
    required this.sellerLng,
    required this.sellerAddress,
    required this.orderType,
    required this.accepted,
    required this.done,
    required this.sellerProfilePic,
    required this.city,
    required this.date,
    required this.driverUID,
    required this.deliveryPrice,
    required this.foodAndAddonPrice,
  });
  Map<String, dynamic> toMap() => {
        "id": id,
        "userUID": userUID,
        "daysBetween": daysBetween,
        "dateStage": dateStage,
        "daysWanted": daysWanted,
        "daysNotWanted": daysNotwanted,
        "startDate": startDate,
        "endDate": endDate,
        "userAddress": userAddress,
        "userLat": userLat,
        "userlng": userlng,
        "userName": userName,
        "userPhoneNumber": userPhoneNumber,
        "sellerUID": sellerUID,
        "sellerName": sellerName,
        "sellerLat": sellerLat,
        "sellerLng": sellerLng,
        "sellerAddress": sellerAddress,
        "orderType": orderType,
        "accepted": accepted,
        "done": done,
        "sellerProfilePic": sellerProfilePic,
        "city": city,
        "date": date,
        "driverUID": driverUID,
        "deliveryPrice": deliveryPrice,
        "foodAndAddonPrice": foodAndAddonPrice,
      };
  static DriverRequestBook fromMap(Map<String, dynamic> data) {
    return DriverRequestBook(
        id: data["id"],
        userUID: data["userUID"],
        daysBetween: data["daysBetween"],
        dateStage: data["dateStage"],
        daysWanted: data["daysWanted"],
        daysNotwanted: data["daysNotWanted"],
        startDate: data["startDate"],
        endDate: data["endDate"],
        userAddress: data["userAddress"],
        userLat: data["userLat"],
        userlng: data["userlng"],
        userName: data["userName"],
        userPhoneNumber: data["userPhoneNumber"],
        sellerUID: data["sellerUID"],
        sellerName: data["sellerName"],
        sellerLat: data["sellerLat"],
        sellerLng: data["sellerLng"],
        sellerAddress: data["sellerAddress"],
        orderType: data["orderType"],
        accepted: data["accepted"],
        done: data["done"],
        sellerProfilePic: data["sellerProfilePic"],
        city: data["city"],
        date: data["date"],
        driverUID: data["driverUID"],
        deliveryPrice: data["deliveryPrice"],
        foodAndAddonPrice: data["foodAndAddonPrice"]);
  }
}
