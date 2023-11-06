import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../../modal/loaiphong_modal.dart';

class SearchRoomIItem extends StatefulWidget {
  const SearchRoomIItem({Key? key}) : super(key: key);

  @override
  _SearchRoomIItemState createState() => _SearchRoomIItemState();
}

class _SearchRoomIItemState extends State<SearchRoomIItem> {
  Loaiphongs? dropdownvalue;
  Map<String, String> header = {
    'ngrok-skip-browser-warning': '1',
  };

  Future<List<Loaiphongs>> getAllCategory() async {
    var baseUrl =
        "glorious-basically-molly.ngrok-free.app', 'mobile/client/loaiphongAll";

    http.Response response =
        await http.get(Uri.parse(baseUrl), headers: header);

    if (response.statusCode == 200) {
      List<Loaiphongs> items = [];
      var jsonData = json.decode(response.body) as List;
      for (var element in jsonData) {
        items.add(element["ClassName"]);
      }
      return items;
    } else {
      throw response.statusCode;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DropDown List"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<List<Loaiphongs>>(
              future: getAllCategory(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data!;
                  return DropdownButton(
                    // Initial Value
                    value: dropdownvalue ?? data[0],

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: data.map((Loaiphongs items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items.ten ?? 'anm'),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (Loaiphongs? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
