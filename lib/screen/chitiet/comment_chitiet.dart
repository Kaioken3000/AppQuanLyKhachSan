import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service/comment_service.dart';

class CommentChitiet extends StatefulWidget {
  const CommentChitiet({
    super.key,
    required this.phongid,
  });

  final String phongid;

  @override
  State<CommentChitiet> createState() => _CommentChitietState();
}

class _CommentChitietState extends State<CommentChitiet> {
  final TextEditingController noidung = TextEditingController();
  final CommentService commentService = CommentService();

  @override
  Widget build(BuildContext context) {
    Future<void> sendComment() async {
      // lấy userid
      WidgetsFlutterBinding.ensureInitialized();
      SharedPreferences pref = await SharedPreferences.getInstance();
      String userid = pref.getInt("userid").toString();

      // Gửi dữ liệu
      dynamic res = await commentService.storeComment(
          noidung.text, userid, widget.phongid);

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      if (res["Message"] == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Tạo bình luận thành công!'),
          backgroundColor: Colors.red.shade300,
        ));
        // Lưu userid - end
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => PhongHome(userid: res["user"][0]["id"])));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Error'),
          backgroundColor: Colors.red.shade300,
        ));
      }
    }

    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.black))),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: noidung, //editing controller of this TextField
              // decoration: const InputDecoration(
              //     icon: Icon(Icons.calendar_today), //icon of text field
              //     labelText: "Ngày ra" //label text of field
              //     ),
              onTapOutside: ((event) {
                FocusScope.of(context).unfocus();
              }),
              decoration: InputDecoration(
                  hintText: "Bình luận",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 0, color: Colors.white)),
                  fillColor: Colors.white),
            ),
          ),
          TextButton(
            child: const Icon(Icons.send),
            style: TextButton.styleFrom(
                // backgroundColor: Colors.white,
                ),
            onPressed: () {
              sendComment();
            },
          ),
        ],
      ),
    );
  }
}
