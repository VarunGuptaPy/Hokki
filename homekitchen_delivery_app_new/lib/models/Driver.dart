class Driver {
  final String name;
  final String phoneNumber;
  final String address;
  final String city;
  final String area;
  final double lat;
  final double lng;
  final String uid;
  final String profilePic;
  final String role;
  final int totalDeliveries;
  final int totalIncome;
  Driver({
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.city,
    required this.area,
    required this.role,
    required this.lat,
    required this.lng,
    required this.profilePic,
    required this.uid,
    required this.totalDeliveries,
    required this.totalIncome,
  });
  Map<String, dynamic> toMap() => {
        "name": name,
        "phoneNumber": phoneNumber,
        "address": address,
        "city": city,
        "area": area,
        "lat": lat,
        "lng": lng,
        "role": role,
        "uid": uid,
        "profilePic": profilePic,
        "totalDeliveries": totalDeliveries,
        "totalIncome": totalIncome,
      };
  static Driver fromMap(Map<String, dynamic> data) {
    return Driver(
      name: data["name"],
      phoneNumber: data["phoneNumber"],
      address: data["address"],
      city: data["city"],
      area: data["area"],
      lat: data["lat"],
      lng: data["lng"],
      profilePic: data["profilePic"],
      role: data["role"],
      uid: data["uid"],
      totalDeliveries: data["totalDeliveries"],
      totalIncome: data["totalIncome"],
    );
  }
}
