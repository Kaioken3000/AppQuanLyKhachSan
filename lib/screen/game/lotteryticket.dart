import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:scratcher/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../modal/user_modal.dart';
import '../../service/diem_service.dart';
import '../../service/user_service.dart';

const List<String> list = <String>['1 lượt', '5 lượt', '10 lượt'];

List<int> number = List.generate(
    16, (index) => (Random().nextInt(10) + Random().nextInt(100 - 50 + 1)));

class LotteryTicket extends StatefulWidget {
  const LotteryTicket({super.key});

  @override
  State<LotteryTicket> createState() => _LotteryTicketState();
}

class _LotteryTicketState extends State<LotteryTicket> {
  late Users user;

  String dropdownValue = list.first;
  late int diem = 0;
  late int luot = 0;
  bool allowScratch = true;

  @override
  void initState() {
    _loadStatusList();
    super.initState();
  }

  _loadStatusList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt("userid");
    var newuser = await getUserById(userid);

    int? luotlottery = prefs.getInt("luotlottery");
    if (luotlottery == null) {
      prefs.setInt("luotlottery", 0);
      luotlottery = prefs.getInt("luotlottery");
    }

    setState(() {
      user = newuser;
      diem = newuser.khachhangs![0].diem!;
      luot = luotlottery!;
    });
  }

  Future<void> thuchiencapnhatdiem(int diemcong) async {
    Map<String, dynamic> data = {
      'khachhangid': user.khachhangs![0].id,
      'diem': diemcong,
    };

    setState(() {
      diem += diemcong;
    });

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
        prefs.setInt("luotlottery", luot);
        diem -= diemtru;
        allowScratch = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
      title: "Ô Số bí ẩn",
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 224, 224, 233),
          appBarTheme: const AppBarTheme(
            color: Color(0xff006df1),
          )),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Ô nhớ"),
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
        body: Column(
          children: [
            Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, left: 20, right: 20),
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
                            items: list
                                .map<DropdownMenuItem<String>>((String value) {
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
                                side: const BorderSide(
                                    color: Colors.white, width: 5),
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
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
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
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
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
                ],
              ),
            ),
            Image.asset(
              'assets/lottery/logo5.jpg',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GridView.builder(
                    itemCount: 16,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemBuilder: (context, index) {
                      return Scratcher(
                        brushSize: 30,
                        threshold: 50,
                        color: Colors.grey,
                        enabled: allowScratch,
                        image: Image.asset('assets/lottery/dollar.png'),
                        onScratchStart: (() {
                          if (luot <= 0) {
                            setState(() {
                              allowScratch = false;
                              showDialog<void>(
                                context: context,
                                barrierDismissible:
                                    true, // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Thông báo'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: const <Widget>[
                                          Text('Bạn cần mua thêm lượt để chơi'),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            });
                          }
                        }),
                        // onChange: (value) => print("Scratch progress: $value%"),
                        onThreshold: () => {
                          setState(() async {
                            luot--;
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setInt("luotlottery", luot);
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
                                            'Bạn được cộng ${number[index]} điểm vào điểm tích luỹ!'),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                            thuchiencapnhatdiem(number[index]);
                          }),
                        },
                        child: Container(
                          color: Colors.white,
                          child: Center(
                            child: Text(
                              '${number[index]}đ',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
