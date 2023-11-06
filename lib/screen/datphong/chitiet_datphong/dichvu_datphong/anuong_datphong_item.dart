import 'package:flutter/material.dart';

import '../../../../modal/anuong_modal.dart';

class AnuongItemList extends StatelessWidget {
  const AnuongItemList({super.key, required this.index, required this.anuong});

  final List<Anuongs> anuong;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${anuong[index].ten}",
            style: const TextStyle(fontSize: 15),
          ),
          Text(
            "x ${anuong[index].pivot!.soluong}",
            style: const TextStyle(fontSize: 15),
          ),
          Row(
            children: [
              Text(
                "${anuong[index].gia! * anuong[index].pivot!.soluong!}",
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
