import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../modal/user_modal.dart';
import '../../service/user_service.dart';
import '../profile/profile.dart';
import 'thongtin_user.dart';

class Xacnhan extends StatefulWidget {
  final int userid;
  final int soPhong;

  const Xacnhan({
    super.key,
    required this.userid,
    required this.soPhong,
  });

  @override
  State<Xacnhan> createState() => _XacnhanState();
}

class _XacnhanState extends State<Xacnhan> {
  TextEditingController soPhong = TextEditingController();

  TextEditingController ngayvao = TextEditingController();
  TextEditingController ngayra = TextEditingController();
  TextEditingController soluong = TextEditingController();

  late int userid;
  late Future<Users> futureUsers;
  //text editing controller for text field

  Future<Users> setValue() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString("ngayvao") != null) {
      ngayvao.text = pref.getString("ngayvao")!;
    }
    if (pref.getString("ngayra") != null) {
      ngayra.text = pref.getString("ngayra")!;
    }
    if (pref.getString("soluong") != null) {
      soluong.text = pref.getString("soluong")!;
    }

    if (pref.getInt("userid") != null) {
      userid = pref.getInt("userid")!;
    }

    return futureUsers = getUserById(userid);
  }

  @override
  void initState() {
    soPhong.text = widget.soPhong.toString();

    //set the initial value of text field
    ngayvao.text = ""; //set the initial value of text field
    ngayra.text = "";
    soluong.text = "0"; //set the initial value of text field

    userid = 0;

    futureUsers = getUserById(userid);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Xác nhận';

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appTitle,
        theme: ThemeData(
            scaffoldBackgroundColor: const Color.fromARGB(255, 224, 224, 233)),
        home: Scaffold(
            appBar: AppBar(
              title: const Text(appTitle),
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
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                // Set the clip behavior of the card
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 0,
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Thông tin người đặt",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FutureBuilder<Users>(
                        future: setValue(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ThongtinUser(user: snapshot.data!);
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }

                          // By default, show a loading spinner.
                          return const CircularProgressIndicator();
                        },
                      ),
                      const Text(
                        "Thông tin đặt phòng",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller:
                            soPhong, //editing controller of this TextField
                        decoration: InputDecoration(
                          labelText: "Số phòng",
                          hintText: "Số phòng",
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        readOnly:
                            true, //set it true, so that user will not able to edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(
                                  2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            //you can implement different kind of Date Format here according to your requirement

                            setState(() {
                              ngayvao.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller:
                            ngayvao, //editing controller of this TextField
                        // decoration: const InputDecoration(
                        //     icon: Icon(Icons.calendar_today), //icon of text field
                        //     labelText: "Ngày vào" //label text of field
                        //     ),
                        decoration: InputDecoration(
                          labelText: "Ngày vào",
                          hintText: "Ngày vào",
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        readOnly:
                            true, //set it true, so that user will not able to edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(
                                  2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            //you can implement different kind of Date Format here according to your requirement

                            setState(() {
                              ngayvao.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller:
                            ngayra, //editing controller of this TextField
                        // decoration: const InputDecoration(
                        //     icon: Icon(Icons.calendar_today), //icon of text field
                        //     labelText: "Ngày ra" //label text of field
                        //     ),
                        decoration: InputDecoration(
                          labelText: "Ngày ra",
                          hintText: "Ngày ra",
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        readOnly:
                            true, //set it true, so that user will not able to edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(
                                  2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            //you can implement different kind of Date Format here according to your requirement

                            setState(() {
                              ngayra.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: soluong,
                        // decoration:
                        //     const InputDecoration(labelText: "Số lượng người ở tối đa"),
                        decoration: InputDecoration(
                          labelText: "Số lượng",
                          hintText: "Số lượng người ở tối đa",
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ], // Only numbers can be entered
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 15)),
                              onPressed: () {},
                              child: const Text(
                                "Đặt phòng",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}
