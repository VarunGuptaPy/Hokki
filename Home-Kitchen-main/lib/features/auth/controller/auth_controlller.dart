import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:home_kitchen/features/auth/repository/auth_repository.dart';

final authcontrollerProvider = Provider(((ref) {
  AuthRepository authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository);
}));

class AuthController {
  final AuthRepository authRepository;
  AuthController({required this.authRepository});
  void signInWithGoogle(BuildContext context) async {
    await authRepository.signInWithGoogle(context);
  }

  void logInWithEmailAndPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    await authRepository.logInWithEmailAndPassword(context, email, password);
  }

  void RegisterWithEmailAndPassword(
      {required String email,
      required String password,
      required String name,
      required BuildContext context}) async {
    await authRepository.registerWithEmailAndPassword(
        context, email, password, name);
  }

  void signInWithPhone(
      {required String phoneNumber, required BuildContext context}) {
    authRepository.signInWithPhone(phoneNumber, context);
  }

  void verifyOtp(
      {required String verificationId,
      required String UserOtp,
      required BuildContext context,
      required String phoneNumber}) {
    authRepository.verifyOtp(
        verificationId: verificationId,
        UserOtp: UserOtp,
        context: context,
        phoneNumber: phoneNumber);
  }

  void uploadSellerDataToFirebase(
      {required File profilePic,
      required BuildContext context,
      required double lat,
      required double lng,
      required String role,
      required Country country,
      required String phoneNumber,
      required String name,
      required String address,
      required Placemark placemark}) {
    authRepository.uploadSellerDataToFirebase(
        profilePic: profilePic,
        context: context,
        lat: lat,
        lng: lng,
        role: role,
        phoneNumber: phoneNumber,
        name: name,
        address: address,
        placemark: placemark);
  }
}
