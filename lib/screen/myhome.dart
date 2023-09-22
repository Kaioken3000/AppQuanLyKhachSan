import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../modal/phong_modal.dart';
import '../modal/user_modal.dart';
import '../service/phong_service.dart';
import '../service/user_service.dart';
import 'phong_list.dart';
import 'profile/profile.dart';
import 'profile/profile_home.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key, required this.userid});
  final int userid;

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      FutureBuilder<List<Phongs>>(
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
      FutureBuilder<Users>(
        future: getUserById(widget.userid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Profile(user: snapshot.data!);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const Center(child: CircularProgressIndicator());
        },
      ),
    ];
    const appTitle = 'Khách sạn Sona';

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appTitle,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 224, 224, 233),
          // appBarTheme: AppBarTheme(
          //   color: Color(0xff006df1),
          // )
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text(appTitle),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
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
              ),
            ],
          ),
          body: Container(
            child: widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Trang chủ',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded),
                label: 'Tài khoản',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ));
  }
}
