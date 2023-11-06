import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../modal/anuong_modal.dart';
import '../../../../modal/user_modal.dart';
import '../../../../service/anuong_service.dart';
import '../../../../service/user_service.dart';
import '../../datphong_home.dart';

class AnuongDatphongChitiet extends StatefulWidget {
  const AnuongDatphongChitiet(
      {super.key,
      required this.anuongs,
      required this.index,
      required this.datphongid});

  final List<Anuongs> anuongs;
  final int index;
  final int datphongid;

  @override
  State<AnuongDatphongChitiet> createState() => _AnuongDatphongChitietState();
}

class _AnuongDatphongChitietState extends State<AnuongDatphongChitiet> {
  TextEditingController soluong = TextEditingController();
  Color cardBackgroundColor = Colors.white;
  late Users user;
  var anuongid = [];

  @override
  void initState() {
    soluong.text = "1"; //set the initial value of text field
    _loadStatusList();
    super.initState();
  }

  _loadStatusList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt("userid");
    var newuser = await getUserById(userid);
    setState(() {
      user = newuser;
    });
  }

  Future<void> anuongDatphong() async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Processing Data'),
      backgroundColor: Colors.green.shade300,
    ));

    Map<String, dynamic> data = {
      'datphongid': widget.datphongid,
      'khachhangid': user.khachhangs![0].id,
      'anuongid': widget.anuongs[widget.index].id,
      'soluong': soluong.text,
    };

    var res = await anuongDatphongStore(data);
    print(data);
    print(res);

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
                    userid: user.id!,
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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Đặt ăn uống",
        theme: ThemeData(
            scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
            appBarTheme:
                const AppBarTheme(color: Color(0xff006df1), elevation: 0)),
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text("Đặt ăn uống"),
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(color: cardBackgroundColor),
              child: Column(
                children: [
                  Image.asset(
                    'assets/${widget.anuongs[widget.index].hinh}',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              "${widget.anuongs[widget.index].ten}",
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
                              "${widget.anuongs[widget.index].gia} đ",
                              style: const TextStyle(),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Số lượng:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextField(
                                controller: soluong,
                                decoration: InputDecoration(
                                  labelText: "Số lượng",
                                  hintText: "Số lượng người ở tối đa",
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () {
                              anuongDatphong();
                            },
                            child: const Text("Chọn"))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
