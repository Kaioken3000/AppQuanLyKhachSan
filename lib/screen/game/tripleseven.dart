import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../modal/user_modal.dart';
import '../../service/diem_service.dart';
import '../../service/user_service.dart';

const List<String> list = <String>['1 lượt', '5 lượt', '10 lượt'];

class TripleSeven extends StatefulWidget {
  const TripleSeven({super.key});

  @override
  State<TripleSeven> createState() => _TripleSevenState();
}

class _TripleSevenState extends State<TripleSeven> {
  late List<StreamController<int>> selected;

  String dropdownValue = list.first;

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

  late int diem = 0;
  late int luot = 0;

  _loadStatusList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt("userid");
    int? luot777 = prefs.getInt("luot777");
    var newuser = await getUserById(userid);

    if (luot777 == null) {
      prefs.setInt("luot777", 0);
      luot777 = prefs.getInt("luot777");
    }
    setState(() {
      luot = luot777!;
      user = newuser;
      diem = newuser.khachhangs![0].diem!;
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

  Future<void> thuchientrudiem(int diemtru, int luotcong) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> data = {
      'khachhangid': user.khachhangs![0].id,
      'diem': diemtru,
    };

    var res = await trudiem(data);
    print(data);
    print(res);

    if (res["Message"] == 200) {
      setState(() {
        luot += luotcong;
        prefs.setInt("luot777", luot);
        diem -= diemtru;
      });
    }
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
              padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                        color: Colors.blue,
                        border: Border.all(color: Colors.white, width: 5),
                      ),
                      width: 180,
                      height: 50,
                      child: Center(
                        child: Text(
                          "Điểm tích luỹ: $diem",
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                        color: Colors.blue,
                        border: Border.all(color: Colors.white, width: 5),
                      ),
                      width: 150,
                      height: 50,
                      child: Center(
                        child: Text(
                          "Lượt: $luot",
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 115.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // const Text("Mua lượt chơi: "),
                  Flexible(
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_drop_down),
                      elevation: 16,
                      onChanged: (String? value) {
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size.fromHeight(40),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.white, width: 5),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        elevation: 5,
                        shadowColor: Colors.black),
                    onPressed: () {
                      showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Basic dialog title'),
                            content: Text('Bạn muốn mua $dropdownValue \n'
                                'Mỗi lượt sẽ trừ 100 điểm tích luỹ'),
                            actions: <Widget>[
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle:
                                      Theme.of(context).textTheme.labelLarge,
                                ),
                                child: const Text('OK'),
                                onPressed: () {
                                  if (dropdownValue == "1 lượt") {
                                    thuchientrudiem(100, 1);
                                  } else if (dropdownValue == "5 lượt") {
                                    thuchientrudiem(500, 5);
                                  } else if (dropdownValue == "10 lượt") {
                                    thuchientrudiem(1000, 10);
                                  }
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle:
                                      Theme.of(context).textTheme.labelLarge,
                                ),
                                child: const Text('Huỷ'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const SizedBox(
                      width: 118,
                      child: Center(
                        child: Text(
                          "Mua lượt chơi",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: bar,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size.fromHeight(40),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.white, width: 5),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    elevation: 5,
                    shadowColor: Colors.black),
                onPressed: luot > 0
                    ? () {
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
                        setState(() async {
                          luot--;
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setInt("luot777", luot);
                        });
                      }
                    : () {
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
                                        'Bạn đã hết lượt hãy mua thêm lượt mới!'),
                                  ],
                                ),
                              ),
                            );
                          },
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
