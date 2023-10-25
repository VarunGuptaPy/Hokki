import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_kitchen/global/widgets/show_dialog.dart';
import 'package:home_kitchen/globals.dart';
import 'package:home_kitchen/screens/sellerHomeScreen.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class SellerAddMaximumUser extends StatefulWidget {
  int maxUser;
  SellerAddMaximumUser({super.key, required this.maxUser});

  @override
  State<SellerAddMaximumUser> createState() => _SellerAddMaximumUserState();
}

class _SellerAddMaximumUserState extends State<SellerAddMaximumUser> {
  final _razorpay = Razorpay();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'maxUser': FieldValue.increment(int.parse(numberController.text)),
    });
    sharedPreferences!
        .setInt('maxUser', widget.maxUser + int.parse(numberController.text));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (c) => SellerHomeScreen()));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    showSnackBar(context, 'Payment failed to process');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  TextEditingController numberController = TextEditingController(text: '0');
  int totalPrice = 0;
  calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount)) * 100;
    return calculatedAmount.toString();
  }

  Future<void> makePayment(amount) async {
    var realAmount = calculateAmount(amount);
    String basicAuth = 'Basic ' +
        base64.encode(
            utf8.encode('rzp_test_SmQqKPZcDx9a2S:UJRX76ZxyyYLm3wwApR3bM0V'));
    final body = jsonEncode({
      'amount': realAmount,
      'currency': 'INR',
    });
    var response = await http.post(
      Uri.parse('https://api.razorpay.com/v1/orders'),
      headers: {'Authorization': basicAuth, 'Content-Type': 'application/json'},
      body: body,
    );
    String orderId = jsonDecode(response.body)['id'];
    var options = {
      'key': 'rzp_test_SmQqKPZcDx9a2S',
      'amount': int.parse(realAmount),
      'order_id': orderId,
      'name': 'Home Kitchen',
      'description': 'for ',
      'timeout': 300,
    };
    _razorpay.open(options);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add more maximum user',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Column(children: [
        Text(
          'Total Price For one user: ₹20',
          style: TextStyle(fontSize: 20),
        ),
        NumberInputWithIncrementDecrement(
          controller: numberController,
          min: 0,
          max: 9,
          onIncrement: (newValue) {
            setState(() {
              totalPrice += 20;
            });
          },
          onDecrement: (newValue) {
            setState(() {
              totalPrice -= 20;
            });
          },
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Total Price : ₹${int.parse(numberController.text) * 20}',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () {
              makePayment('${int.parse(numberController.text) * 20}');
            },
            child: Text('Pay')),
      ]),
    );
  }
}
