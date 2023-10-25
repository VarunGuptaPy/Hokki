import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_upi_payment/easy_upi_payment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homekitchen_delivery_app_new/models/DriversRequest.dart';
import 'package:homekitchen_delivery_app_new/screens/Success_screen.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../widgets/show_dialog.dart';
import 'package:http/http.dart' as http;

class MyDayPayment extends StatefulWidget {
  int? totalPrice;
  DriverRequest? driverRequest;
  Function()? successWork;
  MyDayPayment({
    super.key,
    this.totalPrice,
    this.driverRequest,
    this.successWork,
  });

  @override
  State<MyDayPayment> createState() => _MyDayPaymentState();
}

class _MyDayPaymentState extends State<MyDayPayment> {
  final _razorpay = Razorpay();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    FirebaseFirestore.instance
        .collection("Driver")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("deliveries")
        .doc(widget.driverRequest!.id)
        .update({"stage": "done"}).then((value) {
      DriverRequest? driverRequest2;
      FirebaseFirestore.instance
          .collection("Driver")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("deliveries")
          .doc(widget.driverRequest!.id)
          .get()
          .then((value) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(widget.driverRequest!.userUID)
            .collection('orders')
            .doc(widget.driverRequest!.id)
            .update({"done": true});
        FirebaseFirestore.instance
            .collection("users")
            .doc(widget.driverRequest!.sellerUID)
            .collection('demo')
            .doc(widget.driverRequest!.id)
            .update({"stage": "done", "done": true});
        FirebaseFirestore.instance
            .collection("users")
            .doc(widget.driverRequest!.sellerUID)
            .update({
          "myTotalEarning": FieldValue.increment(widget.totalPrice! * 0.90),
          "unWidraw": FieldValue.increment(widget.totalPrice! * 0.90),
        });
        FirebaseFirestore.instance
            .collection("Driver")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("deliveries")
            .doc(widget.driverRequest!.id)
            .update({
          "done": true,
        });
        driverRequest2 = DriverRequest.fromJson(value.data()!);
        Navigator.pop(context);
      });
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    showSnackBar(context, 'Payment failed to process');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }
  calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount)) * 100;
    return calculatedAmount.toString();
  }

  Future<void> makePayment(amount) async {
    var realAmount = calculateAmount(amount.toString());
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
    // try {
    //   final res = await EasyUpiPaymentPlatform.instance.startPayment(
    //       EasyUpiPaymentModel(
    //           payeeVpa: "varunguptapy@fam",
    //           payeeName: "Varun Gupta",
    //           amount: amount,
    //           description: "Paying to homeKitchen"));
    //   FirebaseFirestore.instance
    //       .collection("Driver")
    //       .doc(FirebaseAuth.instance.currentUser!.uid)
    //       .collection("deliveries")
    //       .doc(widget.driverRequest!.id)
    //       .update({"stage": "done"}).then((value) {
    //     DriverRequest? driverRequest2;
    //     FirebaseFirestore.instance
    //         .collection("Driver")
    //         .doc(FirebaseAuth.instance.currentUser!.uid)
    //         .collection("deliveries")
    //         .doc(widget.driverRequest!.id)
    //         .get()
    //         .then((value) {
    //       FirebaseFirestore.instance
    //           .collection("users")
    //           .doc(widget.driverRequest!.userUID)
    //           .collection('orders')
    //           .doc(widget.driverRequest!.id)
    //           .update({"done": true});
    //       FirebaseFirestore.instance
    //           .collection("users")
    //           .doc(widget.driverRequest!.sellerUID)
    //           .collection('demo')
    //           .doc(widget.driverRequest!.id)
    //           .update({"stage": "done", "done": true});
    //       FirebaseFirestore.instance
    //           .collection("users")
    //           .doc(widget.driverRequest!.sellerUID)
    //           .update({
    //         "myTotalEarning": FieldValue.increment(widget.totalPrice! * 0.90),
    //         "unWidraw": FieldValue.increment(widget.totalPrice! * 0.90),
    //       });
    //       FirebaseFirestore.instance
    //           .collection("Driver")
    //           .doc(FirebaseAuth.instance.currentUser!.uid)
    //           .collection("deliveries")
    //           .doc(widget.driverRequest!.id)
    //           .update({
    //         "done": true,
    //       });
    //       driverRequest2 = DriverRequest.fromJson(value.data()!);
    //       Navigator.pop(context);
    //     });
    //   });
    // } on EasyUpiPaymentException {
    //   showSnackBar(context, "Some error occurred processing payment");
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Text(
                "Pay Online",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              CircleAvatar(
                radius: 60,
                backgroundImage:
                    NetworkImage(widget.driverRequest!.sellerProfilePic),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "To ${widget.driverRequest!.sellerName}",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
              Text("HomeKitchen"),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.60,
                child: ElevatedButton(
                    onPressed: () {},
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child: Text(
                      widget.totalPrice.toString(),
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    )),
              ),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.60,
                child: ElevatedButton(
                    onPressed: () async {
                      await makePayment(widget.totalPrice);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff0052AB)),
                    child: Text(
                      "Pay Now",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
