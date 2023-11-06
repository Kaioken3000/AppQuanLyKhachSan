import 'package:flutter/material.dart';

import '../../../modal/datphong_modal.dart';
import 'chitiet_datphong_item.dart';
import 'dichvu_datphong/dichvu_datphong_list.dart';
import 'phong_datphong/phong_datphong_list.dart';

class ChitietDatphongHome extends StatelessWidget {
  const ChitietDatphongHome({super.key, required this.datphong});

  final Datphongs datphong;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
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
            bottom: const TabBar(
              tabs: [
                Tab(
                  child: Text("Thông tin đặt phòng"),
                ),
                Tab(
                  child: Text("Lịch sử phòng ở"),
                ),
                Tab(
                  child: Text("Lịch sử dịch vụ"),
                ),
              ],
            ),
            title: const Text('Danh sách đặt phòng'),
          ),
          body: TabBarView(
            children: [
              ChitietDatphongItem(datphong: datphong),
              PhongDatphongList(phongs: datphong.phongs!),
              DichvuDatphongList(
                dichvus: datphong.dichvus!,
                anuongs: datphong.anuongs!,
                datphongid: datphong.id!,
              )
            ],
          ),
        ),
      ),
    );
  }
}
