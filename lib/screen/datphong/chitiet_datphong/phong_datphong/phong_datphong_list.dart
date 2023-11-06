import 'package:flutter/material.dart';

import '../../../../modal/phong_modal.dart';
import '../../../phong/phong_items_list.dart';

class PhongDatphongList extends StatelessWidget {
  const PhongDatphongList({super.key, required this.phongs});

  final List<Phongs> phongs;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemCount: phongs.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text("Ngày vào: "),
                          Text(phongs[index].pivot!.ngaybatdauo!),
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Ngày ra: "),
                          Text(phongs[index].pivot!.ngayketthuco!),
                        ],
                      ),
                    ],
                  ),
                ),
                PhongItemList(
                  phongs: phongs,
                  index: index,
                ),
              ],
            );
          }),
    );
  }
}
