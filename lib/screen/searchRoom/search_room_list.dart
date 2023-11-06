import 'package:flutter/material.dart';

import '../../../modal/phong_modal.dart';
import '../../service/phong_service.dart';
import '../phong/phong_items_list.dart';

class SearchRoomList extends StatelessWidget {
  const SearchRoomList(
      {super.key,
      required this.songuoioDrop,
      required this.loaiphongDrop,
      required this.tuychongiaDrop,
      required this.giaphongDrop,
      required this.chinhanhDrop});
  final String songuoioDrop;
  final String loaiphongDrop;
  final String tuychongiaDrop;
  final String giaphongDrop;
  final String chinhanhDrop;

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Danh sách phòng tìm được';

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appTitle,
        theme: ThemeData(
            scaffoldBackgroundColor: const Color.fromARGB(255, 224, 224, 233),
            appBarTheme: const AppBarTheme(
              color: Color(0xff006df1),
            )),
        home: Scaffold(
          appBar: AppBar(
            title: const Text(appTitle),
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
          body: FutureBuilder<List<Phongs>>(
            future: searchPhong(songuoioDrop, loaiphongDrop, tuychongiaDrop,
                giaphongDrop, chinhanhDrop),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('An error has occurred!'),
                );
              } else if (snapshot.hasData) {
                List<Phongs> phongs = snapshot.data!;
                return Column(children: [
                  Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: phongs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return PhongItemList(
                            phongs: phongs,
                            index: index,
                          );
                        }),
                  ),
                ]);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ));
  }
}
