import 'package:flutter/material.dart';
import '../../modal/user_modal.dart';

class ThongtinUser extends StatelessWidget {
  const ThongtinUser({super.key, required this.user});

  final Users user;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Tên tài khoản: ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Text(user.username ?? '')
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Email: ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Text(user.email ?? '')
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Số điện thoại: ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Text(user.khachhangs![0].sdt.toString())
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Giới tính: ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Text(user.khachhangs![0].gioitinh ?? '')
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Văn bằng: ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Text(user.khachhangs![0].vanbang ?? '')
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Điểm: ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Row(
              children: [
                Text(user.khachhangs![0].diem.toString()),
                const Text(" điểm: "),
              ],
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ]),
    );
  }
}
