import 'package:flutter/material.dart';

import '../../modal/datphong_modal.dart';
import 'datphong_item_list.dart';

class DatphongsList extends StatelessWidget {
  const DatphongsList({super.key, required this.datphongs});

  final List<Datphongs> datphongs;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20.0, top: 20.0),
          child: Text("Lịch sử các đặt phòng đã thực hiện", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
        ),
        Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: datphongs.length,
              itemBuilder: (BuildContext context, int index) {
                return DatphongItemList(
                  datphongs: datphongs,
                  index: index,
                );
              }),
        )
      ],
    );
  }
}
