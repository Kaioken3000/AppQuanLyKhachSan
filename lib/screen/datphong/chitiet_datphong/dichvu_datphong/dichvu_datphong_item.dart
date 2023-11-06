import 'package:flutter/material.dart';

import '../../../../modal/dichvu_modal.dart';

class DichvuDatphongItemList extends StatelessWidget {
  const DichvuDatphongItemList(
      {super.key, required this.dichvu, required this.index});

  final List<Dichvus> dichvu;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${dichvu[index].ten}",
            style: const TextStyle(fontSize: 15),
          ),
          Row(
            children: [
              Text(
                "${dichvu[index].giatien}",
                style: const TextStyle(),
              ),
              const Text(
                "đ",
                style: TextStyle(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
