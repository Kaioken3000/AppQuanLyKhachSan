import 'dart:ui';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:khachsanb1910261/screen/game/memorycard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../modal/user_modal.dart';
import '../../service/diem_service.dart';
import '../../service/user_service.dart';

const List<String> list = <String>['1 lượt', '5 lượt', '10 lượt'];

class MemoryCardPage2 extends StatefulWidget {
  const MemoryCardPage2({super.key});

  @override
  State<MemoryCardPage2> createState() => _MemoryCardPage2State();
}

class _MemoryCardPage2State extends State<MemoryCardPage2> {
  MemoryCard game = MemoryCard();
  int score = 0;
  int move = 0;
  late Users user;

  String dropdownValue = list.first;
  late int diem = 0;
  late int luot = 0;

  @override
  void initState() {
    game.initGame();
    _loadStatusList();
    super.initState();
  }

  _loadStatusList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt("userid");
    var newuser = await getUserById(userid);

    int? luotonho = prefs.getInt("luotonho");
    if (luotonho == null) {
      prefs.setInt("luotonho", 0);
      luotonho = prefs.getInt("luotonho");
    }

    setState(() {
      user = newuser;
      diem = newuser.khachhangs![0].diem!;
      luot = luotonho!;
    });
  }

  Future<void> thuchiencapnhatdiem() async {
    Map<String, dynamic> data = {
      'khachhangid': user.khachhangs![0].id,
      'diem': score,
    };

    setState(() {
      diem += score;
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
        prefs.setInt("luotonho", luot);
        diem -= diemtru;
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
      title: "Ô nhớ",
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
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Ô nhớ",
                style: TextStyle(fontSize: 30),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Text(
                "Lượt: $move",
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                "Điểm: $score",
                style: const TextStyle(fontSize: 20),
              ),
            ]),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: GridView.builder(
                    itemCount: game.gameImg!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemBuilder: (context, index) {
                      return FlipCard(
                        controller: game.controller![index],
                        fill: Fill
                            .fillBack, // Fill the back side of the card to make in the same size as the front.
                        direction: FlipDirection.HORIZONTAL, // default
                        side: CardSide.FRONT, // The side to initially display.
                        front: GestureDetector(
                          onTap: (() async {
                            if (luot > 0) {
                              setState(() {
                                move++;
                              });
                              await game.controller![index].toggleCard();
                              game.matchCheck
                                  .add({index: game.cards_list[index]});
                              if (game.matchCheck.length == 2) {
                                if (game.matchCheck[0].values.first ==
                                    game.matchCheck[1].values.first) {
                                  setState(() {
                                    score++;
                                  });
                                } else {
                                  await Future.delayed(
                                      const Duration(milliseconds: 600), () {
                                    game.controller![
                                            game.matchCheck[1].keys.first]
                                        .toggleCard();
                                    game.controller![
                                            game.matchCheck[0].keys.first]
                                        .toggleCard();
                                  });
                                }
                                game.matchCheck.clear();
                                if (score == game.gameImg!.length / 2) {
                                  setState(() async {
                                    luot--;
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setInt("luotonho", luot);
                                    showDialog<void>(
                                      context: context,
                                      barrierDismissible:
                                          true, // user must tap button!
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Thông báo'),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                Text(
                                                    'Bạn được cộng $score điểm vào điểm tích luỹ!'),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                    thuchiencapnhatdiem();
                                  });
                                }
                              }
                            } else {
                              showDialog<void>(
                                context: context,
                                barrierDismissible:
                                    true, // user must tap button!
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
                            }
                          }),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                color: Colors.white,
                                image: DecorationImage(
                                    image: AssetImage(game.gameImg![index]),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        back: GestureDetector(
                          onTap: () async {
                            await game.controller![index].toggleCard();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                color: Colors.white,
                                image: DecorationImage(
                                    image: AssetImage(game.cards_list[index]),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        flipOnTouch: false,
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
