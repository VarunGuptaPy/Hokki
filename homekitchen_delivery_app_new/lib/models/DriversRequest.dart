class DriverRequest {
  final String sellerName;
  final String city;
  final double sellerLat;
  final double sellerLng;
  final String sellerPhoneNumber;
  final String sellerProfilePic;
  final String userName;
  final String userAddress;
  final String orderType;
  final double latUser;
  final double lngUser;
  final String userUID;
  final String sellerUID;
  final String id;
  final bool accepted;
  final String stage;
  final bool done;
  final String date;
  final double deliveryPrice;
  final String totalPrice;
  DriverRequest({
    required this.deliveryPrice,
    required this.totalPrice,
    required this.done,
    required this.date,
    required this.userUID,
    required this.sellerUID,
    required this.id,
    required this.accepted,
    required this.sellerName,
    required this.city,
    required this.latUser,
    required this.lngUser,
    required this.orderType,
    required this.stage,
    required this.sellerLat,
    required this.sellerLng,
    required this.sellerPhoneNumber,
    required this.sellerProfilePic,
    required this.userAddress,
    required this.userName,
  });
  Map<String, dynamic> toJson() {
    return {
      "sellerName": sellerName,
      "city": city,
      "sellerLat": sellerLat,
      "sellerLng": sellerLng,
      "sellerPhoneNumber": sellerPhoneNumber,
      "sellerProfilePic": sellerProfilePic,
      "userName": userName,
      "userAddress": userAddress,
      "orderType": orderType,
      "latUser": latUser,
      "lngUser": lngUser,
      "done": done,
      "accepted": accepted,
      "id": id,
      "userUID": userUID,
      "sellerUID": sellerUID,
      "stage": stage,
      "date": date,
      "deliveryPrice": deliveryPrice,
      "totalPrice": totalPrice,
    };
  }

  static DriverRequest fromJson(Map<String, dynamic> data) {
    return DriverRequest(
      sellerName: data["sellerName"],
      city: data["city"],
      stage: data["stage"],
      latUser: data["latUser"],
      lngUser: data["lngUser"],
      orderType: data["orderType"],
      sellerLat: data["sellerLat"],
      sellerLng: data["sellerLng"],
      sellerPhoneNumber: data["sellerPhoneNumber"],
      sellerProfilePic: data["sellerProfilePic"],
      userAddress: data["userAddress"],
      userName: data["userName"],
      accepted: data["accepted"],
      id: data["id"],
      done: data["done"],
      userUID: data["userUID"],
      sellerUID: data["sellerUID"],
      date: data["date"],
      deliveryPrice: data["deliveryPrice"],
      totalPrice: data["totalPrice"],
    );
  }
}
