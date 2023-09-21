import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:http/http.dart' as http;

class StripePaymentScreen extends StatefulWidget {
  const StripePaymentScreen({Key? key, required this.giatien})
      : super(key: key);

  final int giatien;
  @override
  State<StripePaymentScreen> createState() => _StripePaymentScreenState();
}

class _StripePaymentScreenState extends State<StripePaymentScreen> {
  Map<String, dynamic>? paymentIntent;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPaymentSheet();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: _displayPaymentSheet, child: const Text("Đặt phòng")),
    );
  }

  Future<void> initPaymentSheet() async {
    try {
      print(paymentIntent);
      await createPaymentIntent(widget.giatien);
      await stripe.Stripe.instance.initPaymentSheet(
        paymentSheetParameters: stripe.SetupPaymentSheetParameters(
          customFlow: false,
          merchantDisplayName: 'Flutter Stripe Demo',
          paymentIntentClientSecret: paymentIntent!["client_secret"],
          customerEphemeralKeySecret: "",
          customerId: "",
          setupIntentClientSecret: "",
          style: ThemeMode.light,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      rethrow;
    }
  }

  Future<void> createPaymentIntent(sotien) async {
    Map<String, String> header = {
      'ngrok-skip-browser-warning': '1',
    };
    var uri = Uri.https('glorious-basically-molly.ngrok-free.app',
        'mobile/client/getPaymentIntent/$sotien');
    final response = await http.get(uri, headers: header);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      paymentIntent = jsonDecode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load user');
    }
  }

  Future<void> _displayPaymentSheet() async {
    try {
      await stripe.Stripe.instance.presentPaymentSheet(
          options: const stripe.PaymentSheetPresentOptions(timeout: 1200000));

      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text('Payment successfully completed'),
      //   ),
      // );
      
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$e'),
        ),
      );
    }
  }
}
