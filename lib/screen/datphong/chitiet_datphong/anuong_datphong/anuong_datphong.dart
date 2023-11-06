import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../modal/anuong_modal.dart';
import '../../../../service/anuong_service.dart';
import 'anuong_datphong_list.dart';

class AnuongDatphongList extends StatelessWidget {
  const AnuongDatphongList({super.key, required this.datphongid});
  final int datphongid;

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Danh sách đặt phòng';

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appTitle,
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Đặt ăn uống"),
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
          body: FutureBuilder<List<Anuongs>>(
            future: fetchAnuongs(http.Client()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return AnuongDatphongItemList(
                              anuongs: snapshot.data!,
                              index: index,
                              datphongid: datphongid,
                            );
                          }),
                    )
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ));
  }
}
