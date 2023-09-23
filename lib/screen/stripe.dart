import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:http/http.dart' as http;

import '../modal/user_modal.dart';
import '../service/datphong_service.dart';
import 'phong/phong_home.dart';

class StripePaymentScreen extends StatefulWidget {
  const StripePaymentScreen(
      {Key? key,
      required this.giatien,
      required this.ngaydat,
      required this.ngaytra,
      required this.soluong,
      required this.phongid,
      required this.user})
      : super(key: key);

  final String ngaydat;
  final String ngaytra;
  final String soluong;
  final String phongid;
  final int giatien;
  final Users user;

  @override
  State<StripePaymentScreen> createState() => _StripePaymentScreenState();
}

class _StripePaymentScreenState extends State<StripePaymentScreen> {
  Map<String, dynamic>? paymentIntent;
  final DatphongService datphongService = DatphongService();

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
      dynamic message = datphongService.thanhtoan(
        widget.ngaydat,
        widget.ngaytra,
        int.parse(widget.soluong),
        int.parse(widget.phongid),
        widget.giatien,
        paymentIntent!['id'],
        widget.user,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đặt phòng thành công'),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PhongHome(
                  userid: widget.user.id!,
                )),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$e'),
        ),
      );
    }
  }
}
