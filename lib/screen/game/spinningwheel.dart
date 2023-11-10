import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../modal/user_modal.dart';
import '../../service/diem_service.dart';
import '../../service/user_service.dart';

List<Color> colors = [
  const Color.fromARGB(255, 255, 86, 34),
  Colors.deepOrange,
  Colors.orange,
  const Color.fromARGB(255, 255, 200, 0),
  const Color.fromARGB(255, 255, 86, 34),
  Colors.deepOrange,
  Colors.orange,
  const Color.fromARGB(255, 255, 200, 0),
  Colors.deepOrange,
  Colors.orange,
];
List<Color> backgroundcolors = [
  const Color.fromARGB(255, 255, 109, 65),
  Colors.deepOrangeAccent,
  Colors.orangeAccent,
  const Color.fromARGB(255, 244, 201, 47),
  const Color.fromARGB(255, 255, 109, 65),
  Colors.deepOrangeAccent,
  Colors.orangeAccent,
  const Color.fromARGB(255, 244, 201, 47),
  Colors.deepOrangeAccent,
  Colors.orangeAccent,
];

List<String> labels = [
  "1 điểm",
  "2 điểm",
  "3 điểm",
  "4 điểm",
  "5 điểm",
  "6 điểm",
  "7 điểm",
  "8 điểm",
  "9 điểm",
  "10 điểm",
];

const List<String> list = <String>['1 lượt', '5 lượt', '10 lượt'];

List<FortuneItem> allItems = List.generate(
  labels.length,
  (index) => FortuneItem(
    child: Text(
      labels[index],
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
    ),
    style: FortuneItemStyle(
      color: colors[index],
      // borderColor: backgroundcolors[index],
      borderColor: Colors.white,
      borderWidth: 5,
    ),
  ),
);

class SpinningWheelPage extends StatefulWidget {
  const SpinningWheelPage({Key? key}) : super(key: key);

  @override
  State<SpinningWheelPage> createState() => _SpinningWheelPageState();
}

class _SpinningWheelPageState extends State<SpinningWheelPage> {
  StreamController<int> selected = StreamController<int>();
  var randomval = 0;
  late Users user;

  late int diem = 0;
  late int luot = 0;
  String dropdownValue = list.first;

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
    int? luotspinning = prefs.getInt("luotspinning");

    if (luotspinning == null) {
      prefs.setInt("luotspinning", 0);
      luotspinning = prefs.getInt("luotspinning");
    }

    setState(() {
      luot = luotspinning!;
      user = newuser;
      diem = newuser.khachhangs![0].diem!;
    });
  }

  Future<void> thuchiencapnhatdiem() async {
    Map<String, dynamic> data = {
      'khachhangid': user.khachhangs![0].id,
      'diem': randomval + 1,
    };

    var res = await capnhatdiem(data);
    setState(() {
      diem += (randomval + 1);
    });
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
        prefs.setInt("luotspinning", luot);
        diem -= diemtru;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff006df1),
        elevation: 0,
        title: const Text("Vòng xoay may mắn"),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/spinning_wheel.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                        border: Border.all(
                          color: Colors.white,
                          width: 5,
                        ),
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
                                'Mỗi lượt sẽ trừ 5 điểm tích luỹ'),
                            actions: <Widget>[
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle:
                                      Theme.of(context).textTheme.labelLarge,
                                ),
                                child: const Text('OK'),
                                onPressed: () {
                                  if (dropdownValue == "1 lượt") {
                                    thuchientrudiem(5, 1);
                                  } else if (dropdownValue == "5 lượt") {
                                    thuchientrudiem(25, 5);
                                  } else if (dropdownValue == "10 lượt") {
                                    thuchientrudiem(50, 10);
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
                      side: const BorderSide(color: Colors.white, width: 5),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    elevation: 5,
                    shadowColor: Colors.black),
                onPressed: luot > 0
                    ? () {
                        setState(
                          () => selected.add(
                            randomval = Fortune.randomInt(0, allItems.length),
                          ),
                        );

                        setState(() async {
                          luot--;
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setInt("luotspinning", luot);
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
