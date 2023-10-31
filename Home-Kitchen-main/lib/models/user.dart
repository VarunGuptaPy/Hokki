import 'package:http/http.dart';

class Users {
  String name;
  String role;
  String phoneNumber;
  String uid;
  String token;
  Users({
    required this.token,
    required this.uid,
    required this.name,
    required this.role,
    required this.phoneNumber,
  });
  Map<String, dynamic> toMap() => {
        'name': name,
        'role': role,
        'phoneNumber': phoneNumber,
        'uid': uid,
        'Token': token,
      };
  static Users fromMap(Map<String, dynamic> data) {
    return Users(
        token: data['Token'],
        uid: data['uid'],
        name: data['name'],
        role: data['role'],
        phoneNumber: data['phoneNumber'],);
  }
}
