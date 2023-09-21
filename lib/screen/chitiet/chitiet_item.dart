import 'package:flutter/material.dart';
import '../../modal/phong_modal.dart';
import 'xacnhan.dart';

class ChitietItem extends StatelessWidget {
  const ChitietItem({super.key, required this.phongs});

  final Phongs phongs;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 700,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          // Set the shape of the card using a rounded rectangle border with a 8 pixel radius
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          // Set the clip behavior of the card
          clipBehavior: Clip.antiAliasWithSaveLayer,
          // Define the child widgets of the card
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Display an image at the top of the card that fills the width of the card and has a height of 160 pixels
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/${phongs.hinhs![0].vitri}',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Add a container with padding that contains the card's title, text, and buttons
              Container(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Display the card's title using a font size of 24 and a dark grey color
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
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text('${phongs.loaiphongs!.gia}đ',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold))
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Thiết bị: "),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 180),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          ListView.builder(
                              itemCount: phongs.thietbis?.length,
                              physics: const ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index2) {
                                int dem = index2 + 1;
                                return Text(
                                    '$dem. ${phongs.thietbis![index2].ten ?? ''}');
                              }),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Giường: "),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 180),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          ListView.builder(
                              itemCount: phongs.giuongs?.length,
                              physics: const ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index2) {
                                int dem = index2 + 1;
                                return Text(
                                    '$dem. ${phongs.giuongs![index2].ten ?? ''}');
                              }),
                        ],
                      ),
                    ),
                    Container(height: 10),
                  ],
                ),
              ),
              // Add a small space between the card and the next widget
              Container(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
