import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../modal/phong_modal.dart';
import '../chitiet/chitiet_home.dart';
import '../chitiet/xacnhan.dart';

class SearchItemList extends StatelessWidget {
  const SearchItemList({super.key, required this.phongs, required this.index});

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
      child: Card(
        elevation: 0,
        // Set the shape of the card using a rounded rectangle border with a 8 pixel radius
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        // Set the clip behavior of the card
        clipBehavior: Clip.antiAliasWithSaveLayer,
        // Define the child widgets of the card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Add a container with padding that contains the card's title, text, and buttons
            Column(
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
                      Container(width: 10),
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Icon(Icons.place, color: Colors.blue),
                                Text(
                                  phongs[index].chinhanhs!.thanhpho ?? '',
                                ),
                              ],
                            ),
                            // Add some spacing between the title and the subtitle
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    "${phongs[index].loaiphongs!.gia.toString()}đ",
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 254, 178, 0),
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                // Add a text button labeled "SHARE" with black foreground color and an accent color for the text
                                TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.black,
                                  ),
                                  child: const Text(
                                    "ĐẶT PHÒNG",
                                  ),
                                  onPressed: () async {
                                    WidgetsFlutterBinding.ensureInitialized();
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    var userid = prefs.getInt("userid");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Xacnhan(
                                              userid: userid!,
                                              soPhong: phongs[index].soPhong!)),
                                    );
                                  },
                                ),
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
          ],
        ),
      ),
    );
  }
}
