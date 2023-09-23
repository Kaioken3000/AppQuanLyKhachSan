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
