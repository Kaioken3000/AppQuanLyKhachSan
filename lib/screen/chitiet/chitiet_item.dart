import 'package:flutter/material.dart';
import 'package:khachsanb1910261/modal/comment_modal.dart';
import '../../modal/phong_modal.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;

import '../../service/comment_service.dart';
import '../virtualtour/virtualtourpage.dart';
import 'comment_chitiet.dart';
import 'datphong_input.dart';
import 'show_comment_phong.dart';

class ChitietItem extends StatelessWidget {
  const ChitietItem(
      {super.key,
      required this.phongs,
      required this.kqngay,
      required this.kqo});

  final Phongs phongs;
  final int kqngay;
  final int kqo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'assets/${phongs.hinhs![0].vitri}',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, bottom: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 8),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      VirtualtourPage(phongid: phongs.soPhong!),
                                ),
                              );
                            },
                            child: const Text("Xem virtual tour"),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Phòng: ",
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                Text(
                                  phongs.soPhong.toString(),
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.grey[800],
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Giá: ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text('${phongs.loaiphongs!.gia}đ',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Loại phòng: "),
                            Text(phongs.loaiphongs?.ten ?? '')
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("Thiết bị: "),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            ListView.builder(
                                itemCount: phongs.thietbis?.length,
                                physics: const ClampingScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder:
                                    (BuildContext context, int index2) {
                                  int dem = index2 + 1;
                                  return Text(
                                      '$dem. ${phongs.thietbis![index2].ten ?? ''}');
                                }),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("Giường: "),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            ListView.builder(
                                itemCount: phongs.giuongs?.length,
                                physics: const ClampingScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder:
                                    (BuildContext context, int index2) {
                                  int dem = index2 + 1;
                                  return Text(
                                      '$dem. ${phongs.giuongs![index2].ten ?? ''}');
                                }),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("Miêu tả: "),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            ListView.builder(
                                itemCount: phongs.giuongs?.length,
                                physics: const ClampingScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder:
                                    (BuildContext context, int index2) {
                                  return Html(
                                      data: phongs.mieutas![index2].noidung ??
                                          '');
                                }),
                          ],
                        ),
                        Container(height: 10),
                        if (kqngay == 0 && kqo == 0) ...[
                          const Text(
                            "Đặt phòng",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Container(height: 10),
                          DatphongInput(
                            phong: phongs,
                          )
                        ],
                        Container(height: 10),
                        const Text(
                          "Bình luận",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Container(height: 5),
                        FutureBuilder<List<Comments>>(
                          future: fetchCommentsWithSoPhong(
                              http.Client(), phongs.soPhong),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Center(
                                child: Text('An error has occurred!'),
                              );
                            } else if (snapshot.hasData) {
                              return ShowCommentPhong(comment: snapshot.data!);
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                        // ShowCommentPhong(phongs: phongs),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Thêm commnet text field
        CommentChitiet(phongid: phongs.soPhong.toString())
      ],
    );
  }
}
