class UserDemo {
  String date;
  bool done;
  String orderId;
  String sellerAddress;
  String sellerId;
  double sellerLat;
  double sellerLng;
  String sellerName;
  String time;
  List addons;
  String foodprice;
  String addonsPrice;
  String sellerPhoto;
  String totalPrice;
  UserDemo({
    required this.addons,
    required this.done,
    required this.date,
    required this.orderId,
    required this.sellerAddress,
    required this.sellerId,
    required this.sellerLat,
    required this.sellerLng,
    required this.sellerName,
    required this.time,
    required this.sellerPhoto,
    required this.foodprice,
    required this.addonsPrice,
    required this.totalPrice,
  });
  static UserDemo fromMap(Map<String, dynamic> map) => UserDemo(
      sellerPhoto: map['sellerPhoto'],
      foodprice: map['foodprice'],
      totalPrice: map['totalPrice'],
      addonsPrice: map['addonsPrice'],
      addons: map['addons'],
      done: map['done'],
      date: map['date'],
      orderId: map['orderId'],
      sellerAddress: map['sellerAddress'],
      sellerId: map['sellerId'],
      sellerLat: map['sellerLat'],
      sellerLng: map['sellerLng'],
      sellerName: map['sellerName'],
      time: map['time']);
}
