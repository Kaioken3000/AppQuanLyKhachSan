import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../modal/user_modal.dart';
import '../../service/diem_service.dart';
import '../../service/user_service.dart';

List<FortuneItem> allItems = const [
  FortuneItem(
    child: Text(
      "1 điểm",
      style: TextStyle(fontSize: 15),
    ),
    style: FortuneItemStyle(
      color: Color.fromARGB(
          255, 255, 86, 34), // <-- custom circle slice fill color
      borderColor: Color.fromARGB(
          255, 255, 109, 65), // <-- custom circle slice stroke color
      borderWidth: 10, // <-- custom circle slice stroke width
    ),
  ),
  FortuneItem(
    child: Text(
      "2 điểm",
      style: TextStyle(fontSize: 15),
    ),
    style: FortuneItemStyle(
      color: Colors.deepOrange, // <-- custom circle slice fill color
      borderColor:
          Colors.deepOrangeAccent, // <-- custom circle slice stroke color
      borderWidth: 10, // <-- custom circle slice stroke width
    ),
  ),
  FortuneItem(
    child: Text(
      "3 điểm",
      style: TextStyle(fontSize: 15),
    ),
    style: FortuneItemStyle(
      color: Colors.orange, // <-- custom circle slice fill color
      borderColor: Colors.orangeAccent, // <-- custom circle slice stroke color
      borderWidth: 10, // <-- custom circle slice stroke width
    ),
  ),
  FortuneItem(
    child: Text(
      "4 điểm",
      style: TextStyle(fontSize: 15),
    ),
    style: FortuneItemStyle(
      color: Color.fromARGB(
          255, 255, 200, 0), // <-- custom circle slice fill color
      borderColor: Color.fromARGB(
          255, 244, 201, 47), // <-- custom circle slice stroke color
      borderWidth: 10, // <-- custom circle slice stroke width
    ),
  ),
  FortuneItem(
    child: Text(
      "5 điểm",
      style: TextStyle(fontSize: 15),
    ),
    style: FortuneItemStyle(
      color: Color.fromARGB(
          255, 255, 86, 34), // <-- custom circle slice fill color
      borderColor: Color.fromARGB(
          255, 255, 109, 65), // <-- custom circle slice stroke color
      borderWidth: 10, // <-- custom circle slice stroke width
    ),
  ),
  FortuneItem(
    child: Text(
      "6 điểm",
      style: TextStyle(fontSize: 15),
    ),
    style: FortuneItemStyle(
      color: Colors.deepOrange, // <-- custom circle slice fill color
      borderColor:
          Colors.deepOrangeAccent, // <-- custom circle slice stroke color
      borderWidth: 10, // <-- custom circle slice stroke width
    ),
  ),
  FortuneItem(
    child: Text(
      "7 điểm",
      style: TextStyle(fontSize: 15),
    ),
    style: FortuneItemStyle(
      color: Colors.orange, // <-- custom circle slice fill color
      borderColor: Colors.orangeAccent, // <-- custom circle slice stroke color
      borderWidth: 10, // <-- custom circle slice stroke width
    ),
  ),
  FortuneItem(
    child: Text(
      "8 điểm",
      style: TextStyle(fontSize: 15),
    ),
    style: FortuneItemStyle(
      color: Color.fromARGB(
          255, 255, 200, 0), // <-- custom circle slice fill color
      borderColor: Color.fromARGB(
          255, 244, 201, 47), // <-- custom circle slice stroke color
      borderWidth: 10, // <-- custom circle slice stroke width
    ),
  ),
  FortuneItem(
    child: Text(
      "9 điểm",
      style: TextStyle(fontSize: 15),
    ),
    style: FortuneItemStyle(
      color: Colors.deepOrange, // <-- custom circle slice fill color
      borderColor:
          Colors.deepOrangeAccent, // <-- custom circle slice stroke color
      borderWidth: 10, // <-- custom circle slice stroke width
    ),
  ),
  FortuneItem(
    child: Text(
      "10 điểm",
      style: TextStyle(fontSize: 15),
    ),
    style: FortuneItemStyle(
      color: Colors.orange, // <-- custom circle slice fill color
      borderColor: Colors.orangeAccent, // <-- custom circle slice stroke color
      borderWidth: 10, // <-- custom circle slice stroke width
    ),
  ),
];

class SpinningWheelPage extends StatefulWidget {
  const SpinningWheelPage({Key? key}) : super(key: key);

  @override
  State<SpinningWheelPage> createState() => _SpinningWheelPageState();
}

class _SpinningWheelPageState extends State<SpinningWheelPage> {
  StreamController<int> selected = StreamController<int>();
  var randomval = 0;
  late Users user;

  @override
  initState() {
    _loadStatusList();
    super.initState();
  }

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  _loadStatusList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt("userid");
    var newuser = await getUserById(userid);
    setState(() {
      user = newuser;
    });
  }

  Future<void> thuchiencapnhatdiem() async {
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: const Text('Processing Data'),
    //   backgroundColor: Colors.green.shade300,
    // ));

    Map<String, dynamic> data = {
      'khachhangid': user.khachhangs![0].id,
      'diem': randomval + 1,
    };

    var res = await capnhatdiem(data);
    print(data);
    print(res);

    // ScaffoldMessenger.of(context).hideCurrentSnackBar();

    // if (res["Message"] == 200) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: Text('Bạn được cộng ${randomval + 1} vào điểm tích luỹ'),
    //     backgroundColor: Colors.green.shade300,
    //   ));
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: const Text('Error'),
    //     backgroundColor: Colors.red.shade300,
    //   ));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Vòng xoay may mắn",
        theme: ThemeData(
            scaffoldBackgroundColor: const Color.fromARGB(255, 224, 224, 233),
            appBarTheme: const AppBarTheme(
              color: Color(0xff006df1),
            )),
        home: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(0, 0, 0, 0),
              elevation: 0,
              // title: const Text("Vòng xoay may mắn"),
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 100,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/spinning_wheel2.jpg"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Center(
                          child: Text(
                        "Vòng xoay may mắn",
                        style: TextStyle(fontSize: 20),
                      )),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: FortuneWheel(
                          selected: selected.stream,
                          animateFirst: false,
                          duration: const Duration(seconds: 3),
                          items: allItems,
                          onAnimationEnd: () {
                            showDialog<void>(
                              context: context,
                              barrierDismissible: true, // user must tap button!
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Thông báo'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Text(
                                            'Bạn được cộng ${randomval + 1} điểm vào điểm tích luỹ!'),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                            thuchiencapnhatdiem();
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size.fromHeight(40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            elevation: 5,
                            shadowColor: Colors.black),
                        onPressed: () {
                          setState(
                            () => selected.add(
                              randomval = Fortune.randomInt(0, allItems.length),
                            ),
                          );
                        },
                        child: const Text(
                          "Xoay",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
