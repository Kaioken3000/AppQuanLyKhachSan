import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../modal/datphong_modal.dart';
import '../../modal/user_modal.dart';
import '../../service/datphong_service.dart';
import '../../service/user_service.dart';
import 'datphong_list.dart';

class DatphongHome extends StatelessWidget {
  const DatphongHome({super.key, required this.userid});

  final int userid;

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Danh sách đặt phòng';

    return MaterialApp(
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.unknown
          },
        ),
        debugShowCheckedModeBanner: false,
        title: appTitle,
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Danh sách đặt phòng"),
            backgroundColor: const Color(0xff006df1),
            elevation: 0,
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
          body: FutureBuilder<Users>(
            future: getUserById(userid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return FutureBuilder<List<Datphongs>>(
                  // fetch datphong cua
                  future: getDatphongByKhachhangid(
                      http.Client(), snapshot.data!.khachhangs![0].id),
                  builder: (context2, snapshot2) {
                    if (snapshot2.hasError) {
                      return const Center(
                        child: Text('An error has occurred!'),
                      );
                    } else if (snapshot2.hasData) {
                      return DatphongsList(datphongs: snapshot2.data!);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }
}
