import 'package:flutter/material.dart';

import '../../../../modal/anuong_modal.dart';
import 'anuong_datphong_chitiet.dart';

class AnuongDatphongItemList extends StatelessWidget {
  const AnuongDatphongItemList(
      {super.key,
      required this.anuongs,
      required this.index,
      required this.datphongid});

  final List<Anuongs> anuongs;
  final int index;
  final int datphongid;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AnuongDatphongChitiet(
                      anuongs: anuongs,
                      datphongid: datphongid,
                      index: index,
                    )));
      },
      child: Card(
        elevation: 10, // the size of the shadow
        shape: RoundedRectangleBorder(
          side: const BorderSide(
              color: Color.fromARGB(255, 232, 232, 239), width: 5),
          borderRadius: BorderRadius.circular(18),
        ),
        // Define how the card's content should be clipped
        clipBehavior: Clip.antiAliasWithSaveLayer,
        // Define the child widget of the card
        child: Row(
          children: [
            Image.asset(
              'assets/${anuongs[index].hinh}',
              width: 110,
              height: 120,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: 210,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    // Add some spacing between the top of the card and the title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Tên:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(
                          "${anuongs[index].ten}",
                          style: const TextStyle(),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Giá:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(
                          "${anuongs[index].gia} đ",
                          style: const TextStyle(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
