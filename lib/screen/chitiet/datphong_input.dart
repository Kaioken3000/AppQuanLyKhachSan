import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../modal/phong_modal.dart';
import 'xacnhan.dart';

class DatphongInput extends StatefulWidget {
  const DatphongInput({super.key, required this.phong});

  final Phongs phong;

  @override
  State<DatphongInput> createState() => _DatphongInputState();
}

class _DatphongInputState extends State<DatphongInput> {
  TextEditingController ngayvao = TextEditingController();
  TextEditingController ngayra = TextEditingController();
  TextEditingController soluong = TextEditingController();

  //text editing controller for text field
  @override
  void initState() {
    ngayvao.text = ""; //set the initial value of text field
    ngayra.text = "";
    soluong.text = "1"; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Flexible(
            child: TextField(
              controller: ngayvao, //editing controller of this TextField
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
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: TextField(
              controller: ngayra, //editing controller of this TextField
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
          ),
        ]),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Flexible(
              child: TextField(
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
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        // Luu thong tin search bar vao sharerefernce
                        WidgetsFlutterBinding.ensureInitialized();
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        pref.setString("ngayvao", ngayvao.text);
                        pref.setString("ngayra", ngayra.text);
                        pref.setString("soluong", soluong.text);

                        // navigate qua trang show_search
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => ShowSearch(
                        //         ngayvao: ngayvao.text,
                        //         ngayra: ngayra.text,
                        //         soluong: soluong.text,
                        //       ),
                        //     ));WidgetsFlutterBinding.ensureInitialized();
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        var userid = prefs.getInt("userid");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Xacnhan(
                                  userid: userid!,
                                  soPhong: widget.phong.soPhong!)),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15)),
                      child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: const [
                            Text(
                              "ĐẶT",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
