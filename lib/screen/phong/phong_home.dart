import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../modal/phong_modal.dart';
import '../../service/phong_service.dart';
import '../datphong/datphong_home.dart';
import '../game/spinningwheel.dart';
import '../searchRoom/search_room_home.dart';
import 'phong_list.dart';
import '../profile/profile_home.dart';

class PhongHome extends StatefulWidget {
  const PhongHome({super.key, required this.userid});
  final int userid;

  @override
  State<PhongHome> createState() => _PhongHomeState();
}

class _PhongHomeState extends State<PhongHome> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Trang chủ';

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
        theme: ThemeData(
            scaffoldBackgroundColor: const Color.fromARGB(255, 224, 224, 233),
            appBarTheme:
                const AppBarTheme(color: Color(0xff006df1), elevation: 0)),
        home: Scaffold(
          appBar: AppBar(
            // title: Center(child: const Text(appTitle, style: TextStyle(fontSize: 13),)),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchRoomHome()),
                          );
                        },
                        child: const Icon(
                          Icons.search,
                          color: Colors.white,
                        )),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(Icons.person_rounded),
                        tooltip: 'User profile',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProfileHome(userid: widget.userid)),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // body: Container(
          //   child: widgetOptions.elementAt(_selectedIndex),
          // ),
          body: FutureBuilder<List<Phongs>>(
            future: fetchPhongs(http.Client()),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('An error has occurred!'),
                );
              } else if (snapshot.hasData) {
                return PhongsList(phongs: snapshot.data!);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          drawer: Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(
                    height: 100,
                    child: DrawerHeader(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(color: Color(0xff006df1)),
                      child: Text(
                        'Sona',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  ListTile(
                    title: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.end,
                      children: const [
                        Icon(Icons.home),
                        Text(' Trang chủ'),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PhongHome(userid: widget.userid)),
                      );
                    },
                  ),
                  ListTile(
                    title: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.end,
                      children: const [
                        Icon(Icons.person_rounded),
                        Text(' Profile'),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProfileHome(userid: widget.userid)),
                      );
                    },
                  ),
                  ListTile(
                    title: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.end,
                      children: const [
                        Icon(Icons.hotel),
                        Text(' Danh sách đặt phòng'),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DatphongHome(userid: widget.userid)),
                      );
                    },
                  ),
                  ListTile(
                    title: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.end,
                      children: const [
                        Icon(Icons.gamepad),
                        Text(' Game tích điểm'),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SpinningWheelPage()),
                      );
                    },
                  ),
                ]),
          ),
          // bottomNavigationBar: BottomNavigationBar(
          //   items: const <BottomNavigationBarItem>[
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.home),
          //       label: 'Trang chủ',
          //     ),
          //     // BottomNavigationBarItem(
          //     //   icon: Icon(Icons.person_rounded),
          //     //   label: 'Tài khoản',
          //     // ),
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.door_back_door),
          //       label: 'Phòng đã đặt',
          //     ),
          //   ],
          //   currentIndex: _selectedIndex,
          //   onTap: _onItemTapped,
          // ),
        ));
  }
}
