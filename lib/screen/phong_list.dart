import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../modal/phong_modal.dart';
import 'phong_items_list.dart';
import 'search/searchbar.dart';

class PhongsList extends StatelessWidget {
  const PhongsList({super.key, required this.phongs});

  final List<Phongs> phongs;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
          ),
          // Set the clip behavior of the card
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sona xin chào!👋",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Tìm phòng ngay hôm nay",
                      style: TextStyle(),
                    )
                  ],
                ),
              ),
              const SearchBar(),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: phongs.length,
              itemBuilder: (BuildContext context, int index) {
                return PhongItemList(
                  phongs: phongs,
                  index: index,
                );
              }),
        )
      ],
    );
  }
}
