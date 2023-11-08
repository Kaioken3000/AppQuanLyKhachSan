import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:khachsanb1910261/screen/game/memorycard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../modal/user_modal.dart';
import '../../service/diem_service.dart';
import '../../service/user_service.dart';

class MemoryCardPage extends StatefulWidget {
  const MemoryCardPage({super.key});

  @override
  State<MemoryCardPage> createState() => _MemoryCardPageState();
}

class _MemoryCardPageState extends State<MemoryCardPage> {
  MemoryCard game = MemoryCard();
  int score = 0;
  int move = 0;
  late Users user;

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
    setState(() {
      user = newuser;
    });
  }

  Future<void> thuchiencapnhatdiem() async {
    Map<String, dynamic> data = {
      'khachhangid': user.khachhangs![0].id,
      'diem': score,
    };

    var res = await capnhatdiem(data);
    print(data);
    print(res);
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
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            game.gameImg![index] = game.cards_list[index];
                            game.matchCheck
                                .add({index: game.cards_list[index]});
                            move++;
                          });

                          if (game.matchCheck.length == 2) {
                            if (game.matchCheck[0].values.first ==
                                game.matchCheck[1].values.first) {
                              setState(() {
                                score++;
                              });
                              game.matchCheck.clear();
                              if (score == game.gameImg!.length / 2) {
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
                              }
                              // check end game
                            } else {
                              Future.delayed(const Duration(milliseconds: 300),
                                  () {
                                setState(() {
                                  game.gameImg![game.matchCheck[0].keys.first] =
                                      game.hiddenCardpath;
                                  game.gameImg![game.matchCheck[1].keys.first] =
                                      game.hiddenCardpath;
                                  game.matchCheck.clear();
                                });
                              });
                            }
                          }
                        },
                        child: Container(
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                              image: DecorationImage(
                                  image: AssetImage(game.gameImg![index]),
                                  fit: BoxFit.cover)),
                        ),
                      );
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
