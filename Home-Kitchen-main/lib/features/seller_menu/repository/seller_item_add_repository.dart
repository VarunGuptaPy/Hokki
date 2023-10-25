import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_kitchen/models/item.dart';

final sellerItemAddScreenRepositoryProvider = Provider((ref) =>
    SellerItemAddScreenRepository(
        firestore: FirebaseFirestore.instance,
        firebaseAuth: FirebaseAuth.instance));

class SellerItemAddScreenRepository {
  FirebaseFirestore firestore;
  FirebaseAuth firebaseAuth;
  SellerItemAddScreenRepository(
      {required this.firestore, required this.firebaseAuth});
  void saveItemToDatabase({
    required Map<String, dynamic> Monday,
    required Map<String, dynamic> Tuesday,
    required Map<String, dynamic> Wednesday,
    required Map<String, dynamic> Thursday,
    required Map<String, dynamic> Friday,
    required Map<String, dynamic> Saturday,
    required Map<String, dynamic> Sunday,
    required List addons,
    required String price,
  }) async {
    Item item = Item(
        price: price,
        addons: addons,
        Monday: Monday,
        Tuesday: Tuesday,
        Wednesday: Wednesday,
        Thursday: Thursday,
        Friday: Friday,
        Saturday: Saturday,
        Sunday: Sunday);
    await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('items')
        .doc('item')
        .set(item.toMap());
    await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .update({'active': true});
  }
}
