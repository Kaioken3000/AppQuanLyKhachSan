import 'package:flutter/material.dart';

import '../../../../modal/anuong_modal.dart';
import '../../../../modal/dichvu_modal.dart';
import '../anuong_datphong/anuong_datphong.dart';
import 'anuong_datphong_item.dart';
import 'dichvu_datphong_item.dart';
import 'dichvu_item_list.dart';

class DichvuDatphongList extends StatelessWidget {
  const DichvuDatphongList(
      {super.key,
      required this.dichvus,
      required this.anuongs,
      required this.datphongid});

  final List<Dichvus> dichvus;
  final List<Anuongs> anuongs;
  final int datphongid;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        DichvuDatItemList(
          datphongid: datphongid,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40),
          child: ElevatedButton(
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AnuongDatphongList(
                              datphongid: datphongid,
                            )));
              },
              child: const Text("Đặt ăn uống")),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 20.0, left: 25),
          child: Text(
            "Dịch vụ đã sử dụng",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        if (dichvus.isNotEmpty) ...[
          ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: dichvus.length,
              itemBuilder: (BuildContext context, int index) {
                return DichvuDatphongItemList(
                  dichvu: dichvus,
                  index: index,
                );
              }),
        ],
        const Padding(
          padding: EdgeInsets.only(top: 20.0, left: 25),
          child: Text(
            "Dịch vụ ăn uống đã sử dụng",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        if (anuongs.isNotEmpty) ...[
          ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: anuongs.length,
              itemBuilder: (BuildContext context, int index) {
                return AnuongItemList(
                  anuong: anuongs,
                  index: index,
                );
              }),
        ],
      ]),
    );
  }
}
