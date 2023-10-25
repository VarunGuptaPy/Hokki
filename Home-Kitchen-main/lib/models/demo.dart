class Demo {
  String completeAddress;
  String phoneNumber;
  double userLat;
  double userLng;
  String userName;
  bool done;
  String date;
  String time;
  String uid;
  String orderId;
  String userToken;
  String userId;
  String stage;
  double deliveryPrice;
  String totalPrice;
  Demo({
    required this.stage,
    required this.deliveryPrice,
    required this.userId,
    required this.userToken,
    required this.orderId,
    required this.uid,
    required this.date,
    required this.done,
    required this.time,
    required this.completeAddress,
    required this.phoneNumber,
    required this.userLat,
    required this.userLng,
    required this.userName,
    required this.totalPrice,
  });
  Map<String, dynamic> toMap() => {
        'completeAddress': completeAddress,
        'phoneNumber': phoneNumber,
        'userLat': userLat,
        'userLng': userLng,
        'stage': stage,
        'userName': userName,
        'date': date,
        'time': time,
        'done': done,
        'uid': uid,
        'userToken': userToken,
        'userId': userId,
        'orderId': orderId,
        'deliveryPrice': deliveryPrice,
        'totalPrice': totalPrice,
      };
  static Demo fromMap(Map<String, dynamic> data) {
    return Demo(
        totalPrice: data["totalPrice"],
        userId: data['userId'],
        userToken: data['userToken'],
        orderId: data['orderId'],
        uid: data['uid'],
        date: data['date'],
        time: data['time'],
        stage: data["stage"],
        done: data['done'],
        completeAddress: data['completeAddress'],
        phoneNumber: data['phoneNumber'],
        userLat: data['userLat'],
        userLng: data['userLng'],
        deliveryPrice: data['deliveryPrice'],
        userName: data['userName']);
  }
}
