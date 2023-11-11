import 'package:flutter/material.dart';

import 'memorycardpage.dart';
import 'memorycardpage2.dart';
import 'spinningwheel.dart';
import 'tripleseven.dart';

class GameList extends StatelessWidget {
  const GameList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff006df1),
        title: const Text("Game tích điểm"),
      ),
      body: Column(
        children: [
          Expanded(
              child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SpinningWheelPage()),
                  );
                },
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                            image: AssetImage("assets/spinning_wheel2.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                        "Vòng quay may mắn",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TripleSeven()),
                  );
                },
                child: Column(
                  children: [
                    Container(
                      height: 175,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                          image: AssetImage("assets/slottitle2.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      padding: const EdgeInsets.all(8),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                        "777",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MemoryCardPage2()),
                  );
                },
                child: Column(
                  children: [
                    Container(
                      height: 175,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                          image: AssetImage("assets/memorycard/memorycard.PNG"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      padding: const EdgeInsets.all(8),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                        "Ô nhớ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                    ),
                  ],
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
