import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../modal/user_modal.dart';
import '../../service/diem_service.dart';
import '../../service/user_service.dart';

class TripleSeven extends StatefulWidget {
  const TripleSeven({super.key});

  @override
  State<TripleSeven> createState() => _TripleSevenState();
}

class _TripleSevenState extends State<TripleSeven> {
  late List<StreamController<int>> selected;

  var randomval1 = 0;
  var randomval2 = 0;
  var randomval3 = 0;

  List<IconData> icons = [
    Icons.back_hand,
    Icons.pending_rounded,
    Icons.access_alarm,
    Icons.adb,
    Icons.hail_rounded,
  ];

  List<String> images = [
    'assets/slotgame/image_4.png',
    'assets/slotgame/image_5.png',
    'assets/slotgame/image_6.png',
    'assets/slotgame/image_3.png',
    'assets/slotgame/image_1.png',
    'assets/slotgame/image_2.png',
  ];

  late List<FortuneItem> items;
  late List<Widget> bar;
  late List<int> duration;

  late Users user;

  _loadStatusList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt("userid");
    var newuser = await getUserById(userid);
    setState(() {
      user = newuser;
    });
  }

  Future<void> thuchiencapnhatdiem() async {
    Map<String, dynamic> data = {
      'khachhangid': user.khachhangs![0].id,
      'diem': 100,
    };

    var res = await capnhatdiem(data);
    print(data);
    print(res);
  }

  @override
  void initState() {
    _loadStatusList();
    selected = List.generate(3, (index) => StreamController<int>());
    duration = [1500, 2000, 2500];
    items = List.generate(
      images.length,
      (index) => FortuneItem(
          child: RotatedBox(
            quarterTurns: 1,
            child: Container(
              height: 400,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    image: AssetImage(images[index]), fit: BoxFit.fill),
              ),
            ),
          ),
          style: const FortuneItemStyle(borderColor: Colors.white)),
    );

    bar = List.generate(
      3,
      (index) => Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 5,
            color: Colors.black,
          ),
        ),
        height: 400,
        child: Expanded(
          child: RotatedBox(
            quarterTurns: 3,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: FortuneBar(
                indicators: const [],
                height: 100,
                duration: Duration(milliseconds: duration[index]),
                selected: selected[index].stream,
                animateFirst: false,
                items: items,
                onAnimationEnd: () => {
                  if (randomval1 == randomval2 && randomval2 == randomval3)
                    {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: true, // user must tap button!
                        builder: (BuildContext context) {
                          thuchiencapnhatdiem();
                          return AlertDialog(
                            title: const Text('Thông báo'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: const <Widget>[
                                  Text(
                                      'Bạn được cộng 100 điểm vào điểm tích luỹ!'),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    }
                },
              ),
            ),
          ),
        ),
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    selected[0].close();
    selected[1].close();
    selected[2].close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("777"),
        backgroundColor: const Color(0xff006df1),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/slotgame/bg.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: bar,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size.fromHeight(40),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.white, width: 5),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    elevation: 5,
                    shadowColor: Colors.black),
                onPressed: () {
                  setState(
                    () => selected[0].add(
                      randomval1 = Fortune.randomInt(0, items.length),
                    ),
                  );
                  setState(
                    () => selected[1].add(
                      randomval2 = Fortune.randomInt(0, items.length),
                    ),
                  );
                  setState(
                    () => selected[2].add(
                      randomval3 = Fortune.randomInt(0, items.length),
                    ),
                  );
                },
                child: const SizedBox(
                  width: 100,
                  child: Center(
                    child: Text(
                      "Xoay",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
