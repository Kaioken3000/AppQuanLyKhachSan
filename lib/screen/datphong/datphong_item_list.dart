import 'package:flutter/material.dart';

import '../../modal/datphong_modal.dart';
import 'chitiet_datphong/chitiet_datphong_home.dart';

class DatphongItemList extends StatelessWidget {
  const DatphongItemList(
      {super.key, required this.datphongs, required this.index});

  final List<Datphongs> datphongs;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ChitietDatphongHome(datphong: datphongs[index]),
            ));
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Add padding around the row widget
            Padding(
              padding: const EdgeInsets.all(20),
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    // Add some spacing between the top of the card and the title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Mã đặt phòng:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(
                          "${datphongs[index].id}",
                          style: const TextStyle(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Phòng đang ở:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(
                          "phòng ${datphongs[index].phongs![datphongs[index].phongs!.length - 1].soPhong}",
                          style: const TextStyle(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Ngày đặt:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(
                          "${datphongs[index].ngaydat}",
                          style: const TextStyle(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Ngày trả:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(
                          "${datphongs[index].ngaytra}",
                          style: const TextStyle(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Số người ở:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(
                          "${datphongs[index].soluong}",
                          style: const TextStyle(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Tình trạng đặt phòng: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "- Xử lý:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    if (datphongs[index].tinhtrangxuly !=
                                        0) ...[
                                      const Chip(
                                        label: Text(
                                          "Đã xử lý",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor: Colors.green,
                                      )
                                    ] else ...[
                                      const Chip(
                                        label: Text(
                                          "Chưa xử lý",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor: Colors.red,
                                      )
                                    ],
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "- Nhận phòng:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    if (datphongs[index].tinhtrangnhanphong !=
                                        0) ...[
                                      const Chip(
                                        label: Text(
                                          "Đã nhận phòng",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor: Colors.green,
                                      )
                                    ] else ...[
                                      const Chip(
                                        label: Text(
                                          "Chưa nhận phòng",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor: Colors.red,
                                      )
                                    ],
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "- Thanh toán:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    if (datphongs[index].tinhtrangthanhtoan !=
                                        0) ...[
                                      const Chip(
                                        label: Text(
                                          "Đã thanh toán",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor: Colors.green,
                                      )
                                    ] else ...[
                                      const Chip(
                                        label: Text(
                                          "Chưa thanh toán",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor: Colors.red,
                                      )
                                    ],
                                  ],
                                ),
                              ],
                            )),
                      ],
                    ),
                    const SizedBox(height: 12),
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
