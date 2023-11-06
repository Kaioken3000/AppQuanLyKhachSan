import 'package:flutter/material.dart';

import '../../../modal/datphong_modal.dart';

class ChitietDatphongItem extends StatelessWidget {
  const ChitietDatphongItem({super.key, required this.datphong});

  final Datphongs datphong;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
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
                        "${datphong.id}",
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
                        "phòng ${datphong.phongs![datphong.phongs!.length - 1].soPhong}",
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
                        "${datphong.ngaydat}",
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
                        "${datphong.ngaytra}",
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
                        "${datphong.soluong}",
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
                                  if (datphong.tinhtrangxuly != 0) ...[
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
                                  if (datphong.tinhtrangnhanphong != 0) ...[
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
                                  if (datphong.tinhtrangthanhtoan != 0) ...[
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
                  const SizedBox(height: 30),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Lịch sử thanh toán: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(10),
                          child: Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                // padding: const EdgeInsets.all(10),
                                itemCount: datphong.thanhtoans!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        if (datphong
                                                .thanhtoans![index].loaitien ==
                                            "datcoc") ...[
                                          const Text(
                                            "- Tiền đặt cọc: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ] else ...[
                                          const Text(
                                            "- Tiền thanh toán: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ],
                                        Text(
                                            "${datphong.thanhtoans![index].gia}đ"),
                                      ],
                                    ),
                                  );
                                }),
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
    );
  }
}
