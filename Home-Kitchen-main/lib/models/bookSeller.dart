import 'package:http/http.dart';

class BookSeller {
  String id;
  String userUID;
  String endDate;
  String startDate;
  String userAddress;
  double userLat;
  String userName;
  String userPhoneNumber;
  String userToken;
  double userlng;
  List daysBetween;
  List daysNotWanted;
  List daysWanted;
  double price;
  BookSeller({
    required this.id,
    required this.userUID,
    required this.endDate,
    required this.startDate,
    required this.userAddress,
    required this.userLat,
    required this.userName,
    required this.userPhoneNumber,
    required this.price,
    required this.userlng,
    required this.daysBetween,
    required this.daysNotWanted,
    required this.userToken,
    required this.daysWanted,
  });
  static BookSeller fromMap(Map<String, dynamic> data) => BookSeller(
      price: data['price'],
      userToken: data['userToken'],
      id: data['id'],
      userUID: data['userUID'],
      endDate: data['endDate'],
      startDate: data['startDate'],
      userAddress: data['userAddress'],
      userLat: data['userLat'],
      userName: data['userName'],
      userPhoneNumber: data['userPhoneNumber'],
      userlng: data['userlng'],
      daysBetween: data['daysBetween'],
      daysNotWanted: data['daysNotWanted'],
      daysWanted: data['daysWanted']);
}
