import 'package:flutter/material.dart';
import '../chitiet/chitiet_home.dart';

import '../../modal/phong_modal.dart';
import '../chitiet/xacnhan.dart';

class PhongItemList extends StatelessWidget {
  const PhongItemList({super.key, required this.phongs, required this.index});

  final List<Phongs> phongs;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChitietHome(phong: phongs[index])),
        );
      },
      // child: Card(
      //   elevation: 0,
      //   // Set the shape of the card using a rounded rectangle border with a 8 pixel radius
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(8),
      //   ),
      //   // Set the clip behavior of the card
      //   clipBehavior: Clip.antiAliasWithSaveLayer,
      //   // Define the child widgets of the card
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: <Widget>[
      //       // Display an image at the top of the card that fills the width of the card and has a height of 160 pixels
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: ClipRRect(
      //           borderRadius: BorderRadius.circular(8.0),
      //           child: Image.asset(
      //             'assets/${phongs[index].hinhs![0].vitri}',
      //             height: 200,
      //             width: double.infinity,
      //             fit: BoxFit.cover,
      //           ),
      //         ),
      //       ),
      //       // Add a container with padding that contains the card's title, text, and buttons
      //       Container(
      //         padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: <Widget>[
      //             // Display the card's title using a font size of 24 and a dark grey color
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 Row(
      //                   children: [
      //                     Text(
      //                       "Phòng: ",
      //                       style: TextStyle(
      //                         fontSize: 24,
      //                         color: Colors.grey[800],
      //                       ),
      //                     ),
      //                     Text(
      //                       phongs[index].soPhong.toString(),
      //                       style: TextStyle(
      //                         fontSize: 24,
      //                         color: Colors.grey[800],
      //                       ),
      //                     )
      //                   ],
      //                 ),
      //                 Row(
      //                   children: [
      //                     const Text(
      //                       "Giá: ",
      //                       style: TextStyle(
      //                           fontSize: 20, fontWeight: FontWeight.bold),
      //                     ),
      //                     Text('${phongs[index].loaiphongs!.gia}đ',
      //                         style: const TextStyle(
      //                             fontSize: 20, fontWeight: FontWeight.bold))
      //                   ],
      //                 ),
      //               ],
      //             ),
      //             const SizedBox(
      //               height: 30,
      //             ),
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 const Text("Loại phòng: "),
      //                 Text(phongs[index].loaiphongs?.ten ?? '')
      //               ],
      //             ),
      //             const SizedBox(
      //               height: 10,
      //             ),
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 const Text("Thiết bị: "),
      //                 Expanded(
      //                   child: Column(
      //                     mainAxisAlignment: MainAxisAlignment.end,
      //                     crossAxisAlignment: CrossAxisAlignment.end,
      //                     children: <Widget>[
      //                       ListView.builder(
      //                           itemCount: phongs[index].thietbis?.length,
      //                           physics: const ClampingScrollPhysics(),
      //                           shrinkWrap: true,
      //                           itemBuilder:
      //                               (BuildContext context, int index2) {
      //                             int dem = index2 + 1;
      //                             return Row(
      //                               mainAxisAlignment: MainAxisAlignment.end,
      //                               children: [
      //                                 Text(
      //                                     '$dem. ${phongs[index].thietbis![index2].ten ?? ''}'),
      //                               ],
      //                             );
      //                           }),
      //                     ],
      //                   ),
      //                 )
      //               ],
      //             ),
      //             const SizedBox(
      //               height: 10,
      //             ),
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 const Text("Giường: "),
      //                 Expanded(
      //                   child: Column(
      //                     mainAxisAlignment: MainAxisAlignment.end,
      //                     crossAxisAlignment: CrossAxisAlignment.end,
      //                     children: <Widget>[
      //                       ListView.builder(
      //                           itemCount: phongs[index].giuongs?.length,
      //                           physics: const ClampingScrollPhysics(),
      //                           shrinkWrap: true,
      //                           itemBuilder:
      //                               (BuildContext context, int index2) {
      //                             int dem = index2 + 1;
      //                             return Row(
      //                               mainAxisAlignment: MainAxisAlignment.end,
      //                               children: [
      //                                 Text(
      //                                     '$dem. ${phongs[index].giuongs![index2].ten ?? ''}'),
      //                               ],
      //                             );
      //                           }),
      //                     ],
      //                   ),
      //                 )
      //               ],
      //             ),
      //             Container(height: 10),
      //             // Display the card's text using a font size of 15 and a light grey color
      //             // Add a row with two buttons spaced apart and aligned to the right side of the card
      //             Row(
      //               children: <Widget>[
      //                 // Add a spacer to push the buttons to the right side of the card
      //                 const Spacer(),
      //                 // Add a text button labeled "SHARE" with black foreground color and an accent color for the text
      //                 // TextButton(
      //                 //   style: TextButton.styleFrom(
      //                 //     foregroundColor: Colors.black,
      //                 //   ),
      //                 //   child: const Text(
      //                 //     "ĐẶT PHÒNG",
      //                 //   ),
      //                 //   onPressed: () {
      //                 //     Navigator.push(
      //                 //       context,
      //                 //       MaterialPageRoute(builder: (context) => Xacnhan()),
      //                 //     );
      //                 //   },
      //                 // ),
      //                 // Add a text button labeled "EXPLORE" with black foreground color and an accent color for the text
      //                 // TextButton(
      //                 //   style: TextButton.styleFrom(
      //                 //     foregroundColor: Colors.black,
      //                 //   ),
      //                 //   child: const Text(
      //                 //     "XEM CHI TIẾT",
      //                 //   ),
      //                 //   onPressed: () {
      //                 //     Navigator.push(
      //                 //       context,
      //                 //       MaterialPageRoute(
      //                 //           builder: (context) =>
      //                 //               ChitietHome(phong: phongs[index])),
      //                 //     );
      //                 //   },
      //                 // ),
      //               ],
      //             ),
      //           ],
      //         ),
      //       ),
      //       // Add a small space between the card and the next widget
      //       Container(height: 5),
      //     ],
      //   ),
      // ),
      child: Card(
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
              padding: const EdgeInsets.all(5),
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(Icons.place, color: Colors.blue),
                            Text(
                              phongs[index].chinhanhs!.thanhpho ?? '',
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
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
                                  color: Color.fromARGB(255, 254, 178, 0),
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
