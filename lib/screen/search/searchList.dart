import 'package:flutter/material.dart';
import 'package:khachsanb1910261/screen/search/search_list_item.dart';

import '../../modal/phong_modal.dart';

class SearchList extends StatelessWidget {
  const SearchList({super.key, required this.phongs});

  final List<Phongs> phongs;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: phongs.length,
              itemBuilder: (BuildContext context, int index) {
                return SearchItemList(
                  phongs: phongs,
                  index: index,
                );
              }),
        )
      ],
    );
  }
}
