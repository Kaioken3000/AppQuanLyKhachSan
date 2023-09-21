import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../modal/phong_modal.dart';
import '../../service/phong_service.dart';
import 'searchList.dart';

class ShowSearch extends StatelessWidget {
  const ShowSearch(
      {super.key,
      required this.ngayvao,
      required this.ngayra,
      required this.soluong});

  final String ngayvao;
  final String ngayra;
  final String soluong;

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Danh sách phòng tìm được';

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appTitle,
        theme: ThemeData(scaffoldBackgroundColor: const Color.fromARGB(255, 224, 224, 233)),
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
            future:
                fetchPhongsWithFilter(http.Client(), ngayvao, ngayra, soluong),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('An error has occurred!'),
                );
              } else if (snapshot.hasData) {
                return SearchList(phongs: snapshot.data!);
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
