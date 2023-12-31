import 'package:flutter/material.dart';

import '../../modal/phong_modal.dart';
import 'chitiet_item.dart';

class ChitietHome extends StatelessWidget {
  const ChitietHome(
      {super.key,
      required this.phong,
      required this.kqngay,
      required this.kqo});
  final Phongs phong;
  final int kqngay;
  final int kqo;

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Chi tiết';

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appTitle,
        theme: ThemeData(
            scaffoldBackgroundColor: const Color.fromARGB(255, 224, 224, 233),
            appBarTheme: const AppBarTheme(
              color: Color(0xff006df1),
            )),
        home: Scaffold(
            appBar: AppBar(
              title: const Text(appTitle),
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
            body: ChitietItem(
              phongs: phong,
              kqngay: kqngay,
              kqo: kqo,
            )));
  }
}
