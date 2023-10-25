class Seller {
  final String name;
  final String phoneNumber;
  final String address;
  final String city;
  final String area;
  final double lat;
  final double lng;
  final String role;
  final String uid;
  final int userUnderMe;
  final String profilePic;
  final double unWidraw;
  final double myTotalEarning;
  final bool active;
  final int maxUser;
  final String Token;
  Seller({
    required this.maxUser,
    required this.userUnderMe,
    required this.active,
    required this.Token,
    required this.profilePic,
    required this.uid,
    required this.role,
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.city,
    required this.area,
    required this.lat,
    required this.lng,
    required this.unWidraw,
    required this.myTotalEarning,
  });
  Map<String, dynamic> toMap() => {
        'userUnderMe': userUnderMe,
        'maxUser': maxUser,
        'name': name,
        'phoneNumber': phoneNumber,
        'active': active,
        'address': address,
        'city': city,
        'area': area,
        'lat': lat,
        'lng': lng,
        'role': role,
        'uid': uid,
        'profilePic': profilePic,
        'Token': Token,
        'unWidraw': unWidraw,
        'myTotalEarning': myTotalEarning,
      };
  static Seller fromMap(Map<String, dynamic> data) {
    return Seller(
      maxUser: data['maxUser'],
      userUnderMe: data['userUnderMe'],
      active: data['active'],
      Token: data['Token'],
      profilePic: data['profilePic'],
      uid: data['uid'],
      role: data['role'],
      name: data['name'],
      phoneNumber: data['phoneNumber'],
      address: data['address'],
      city: data['city'],
      area: data['area'],
      lat: data['lat'],
      lng: data['lng'],
      unWidraw: data['unWidraw'],
      myTotalEarning: data['myTotalEarning'],
    );
  }
}
