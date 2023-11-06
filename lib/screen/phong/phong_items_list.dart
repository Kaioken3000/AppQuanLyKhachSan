import 'package:flutter/material.dart';
import '../animationPage.dart';
import '../chitiet/chitiet_home.dart';

import '../../modal/phong_modal.dart';

class PhongItemList extends StatelessWidget {
  const PhongItemList({super.key, required this.phongs, required this.index});

  final List<Phongs> phongs;
  final int index;

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    int kqngay = 0;
    int kqo = 0;

    if (phongs[index].datphongs!.isNotEmpty &&
        phongs[index].danhsachdatphongs!.isNotEmpty) {
      DateTime ngayketthuco = DateTime.parse(phongs[index]
          .danhsachdatphongs![phongs[index].danhsachdatphongs!.length - 1]
          .ngayketthuco
          .toString());
      if (ngayketthuco.compareTo(today) > 0) {
        kqngay++;
      }
      if (phongs[index]
              .datphongs![phongs[index].datphongs!.length - 1]
              .tinhtrangthanhtoan ==
          0) {
        kqo++;
      }
    }
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context,
        //     SlideRightRoute(
        //         page: ChitietHome(
        //       phong: phongs[index],
        //       kqngay: kqngay,
        //       kqo: kqo,
        //     )));
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChitietHome(
                    phong: phongs[index],
                    kqngay: kqngay,
                    kqo: kqo,
                  )),
        );
      },
      child: Card(
        elevation: 10,
        // Define the shape of the card
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        // Define how the card's content should be clipped
        clipBehavior: Clip.antiAliasWithSaveLayer,
        // Define the child widget of the card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Add padding around the row widget
            Padding(
              padding: const EdgeInsets.all(9),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Add an image widget to display an image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.asset(
                      'assets/${phongs[index].hinhs![0].vitri}',
                      height: 100,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Add some spacing between the image and the text
                  Container(width: 20),
                  // Add an expanded widget to take up the remaining horizontal space
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Add some spacing between the top of the card and the title
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Phòng: ${phongs[index].soPhong.toString()}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            if (kqngay != 0 || kqo != 0) ...[
                              const Flexible(
                                  child: Text(
                                "Đã được đặt",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.red),
                              )),
                            ],
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            const Icon(Icons.place, color: Colors.blue),
                            Text(
                              phongs[index].chinhanhs!.thanhpho ?? '',
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        // Add some spacing between the title and the subtitle
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                child: Text(
                              phongs[index].loaiphongs!.ten ?? '',
                              overflow: TextOverflow.ellipsis,
                            )),
                            Flexible(
                                child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Text(
                                "${phongs[index].loaiphongs!.gia.toString()}đ",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  // color: Color.fromARGB(255, 254, 178, 0),
                                  fontSize: 18,
                                ),
                              ),
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
