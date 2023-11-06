import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:khachsanb1910261/service/loaiphong_service.dart';

import '../../modal/chinhanh_modal.dart';
import '../../modal/loaiphong_modal.dart';
import '../../service/chinhanh_service.dart';
import 'search_room_list.dart';

const List<String> listTuychongia = <String>['>', '=', '<'];
const List<String> listGiaphong = <String>[
  '100000',
  '200000',
  '300000',
  '400000',
  '500000',
  '600000'
];
const List<String> listSonguoio = <String>['', '1', '2', '3', '4', '5', '6'];

class SearchRoomBar extends StatefulWidget {
  const SearchRoomBar({super.key});

  @override
  State<SearchRoomBar> createState() => _SearchRoomBarState();
}

class _SearchRoomBarState extends State<SearchRoomBar> {
  Loaiphongs? loaiphongDrop;
  Chinhanhs? chinhanhDrop;
  String giaphongDrop = listGiaphong.first;
  String songuoioDrop = listSonguoio.first;
  String tuychongiaDrop = listTuychongia.first;

  //text editing controller for text field
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
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
                      "Chi nhánh: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Flexible(
                      child: FutureBuilder<List<Chinhanhs>>(
                        future: fetchChinhanhs(http.Client()),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var data = snapshot.data!;
                            chinhanhDrop ??= data[0];
                            return DropdownButton(
                              isExpanded: true,
                              // Initial Value
                              value: chinhanhDrop ?? data[0],

                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),

                              // Array list of items
                              items: data.map((Chinhanhs items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items.ten ?? ''),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (Chinhanhs? newValue) {
                                setState(() {
                                  chinhanhDrop = newValue;
                                });
                              },
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Loại phòng: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Flexible(
                      child: FutureBuilder<List<Loaiphongs>>(
                        future: fetchLoaiphongs(http.Client()),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var data = snapshot.data!;
                            loaiphongDrop ??= data[0];
                            return DropdownButton(
                              isExpanded: true,
                              // Initial Value
                              value: loaiphongDrop ?? data[0],

                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),

                              // Array list of items
                              items: data.map((Loaiphongs items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items.ten ?? ''),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (Loaiphongs? newValue) {
                                setState(() {
                                  loaiphongDrop = newValue;
                                });
                              },
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Giá phòng: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Flexible(
                      child: DropdownButton<String>(
                        value: tuychongiaDrop,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        // elevation: 16,
                        // style: const TextStyle(color: Colors.black),
                        // underline: Container(
                        //   height: 2,
                        //   color: Colors.black,
                        // ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            tuychongiaDrop = value!;
                          });
                        },
                        items: listTuychongia
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value == "<"
                                ? "nhỏ hơn"
                                : (value == "=" ? "bằng" : "lớn hơn")),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: DropdownButton<String>(
                        value: giaphongDrop,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        // elevation: 16,
                        // style: const TextStyle(color: Colors.black),
                        // underline: Container(
                        //   height: 2,
                        //   color: Colors.black,
                        // ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            giaphongDrop = value!;
                          });
                        },
                        items: listGiaphong
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              "$valueđ",
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Số người ở: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Flexible(
                      child: DropdownButton<String>(
                        value: songuoioDrop,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        // elevation: 16,
                        // style: const TextStyle(color: Colors.blue),
                        // underline: Container(
                        //   height: 2,
                        //   color: Colors.deepPurpleAccent,
                        // ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            songuoioDrop = value!;
                          });
                        },
                        items: listSonguoio
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value == '' ? 'tất cả' : value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchRoomList(
                                  songuoioDrop: songuoioDrop,
                                  loaiphongDrop: loaiphongDrop!.ma.toString(),
                                  tuychongiaDrop: tuychongiaDrop,
                                  giaphongDrop: giaphongDrop,
                                  chinhanhDrop: chinhanhDrop!.id.toString())),
                        );
                      },
                      child: const Text("Tìm kiếm"))
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
