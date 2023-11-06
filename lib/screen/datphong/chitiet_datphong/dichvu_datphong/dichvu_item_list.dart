import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../modal/dichvu_modal.dart';
import '../../../../modal/user_modal.dart';
import '../../../../service/dichvu_service.dart';
import '../../../../service/user_service.dart';
import '../../datphong_home.dart';

class DichvuDatItemList extends StatefulWidget {
  const DichvuDatItemList({super.key, required this.datphongid});
  final int datphongid;

  @override
  State<DichvuDatItemList> createState() => _DichvuDatItemListState();
}

class _DichvuDatItemListState extends State<DichvuDatItemList> {
  Dichvus? dichvuDrop = Dichvus();
  Users? user;
  List<Dichvus>? recordList;

  //text editing controller for text field
  @override
  void initState() {
    super.initState();
    _loadStatusList();
  }

  _loadStatusList() async {
    recordList = await fetchDichvus(http.Client());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt("userid");
    var newuser = await getUserById(userid);
    setState(() {
      dichvuDrop = recordList!.first;
      user = newuser;
    });
  }

  Future<void> dichvuDatphong() async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Processing Data'),
      backgroundColor: Colors.green.shade300,
    ));

    Map<String, dynamic> data = {
      'dichvuid': [dichvuDrop!.id],
      'datphongid': widget.datphongid,
      'khachhangid': user!.khachhangs![0].id,
    };

    var res = await dichvuDatphongStore(data);

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    if (res["Message"] == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('OK'),
        backgroundColor: Colors.green.shade300,
      ));
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DatphongHome(
                    userid: user!.id!,
                  )));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Error'),
        backgroundColor: Colors.red.shade300,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 10,
          // Define the shape of the card
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          // Define how the card's content should be clipped
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      "Dich vụ: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Flexible(
                        child: DropdownButton(
                      isExpanded: true,
                      // Initial Value
                      value: dichvuDrop,

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: recordList!.map((Dichvus items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items.ten ?? ''),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (Dichvus? newValue) {
                        setState(() {
                          dichvuDrop = newValue;
                        });
                      },
                    ))
                  ],
                ),
                ElevatedButton(
                    onPressed: () async {
                      // print([dichvuDrop!.id]);
                      // print(user!.khachhangs![0].id);
                      // print(widget.datphongid);

                      // gui du lieu
                      dichvuDatphong();
                    },
                    child: const Text("Đặt dịch vụ")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
