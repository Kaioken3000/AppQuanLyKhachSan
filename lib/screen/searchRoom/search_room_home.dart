import 'package:flutter/material.dart';

import 'search_room_bar.dart';

class SearchRoomHome extends StatelessWidget {
  const SearchRoomHome({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Tìm kiếm phòng';

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appTitle,
        home: Scaffold(
            appBar: AppBar(
              title: const Text("Tìm kiếm phòng"),
              backgroundColor: const Color(0xff006df1),
              elevation: 0,
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
            body: SearchRoomBar()));
  }
}
