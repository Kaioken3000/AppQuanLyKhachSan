import 'package:flutter/material.dart';
import 'package:khachsanb1910261/screen/authScreen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../modal/user_modal.dart';

class Profile extends StatelessWidget {
  const Profile({super.key, required this.user});

  final Users user;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      child: Card(
        elevation: 0,
        // Set the shape of the card using a rounded rectangle border with a 8 pixel radius
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        // Set the clip behavior of the card
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Thông tin tài khoản",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.verified_user_sharp, size: 100),
              ],
            ),
            SizedBox(
              height: 20,
            ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      WidgetsFlutterBinding.ensureInitialized();
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      pref.remove("userid");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: const Text("Đăng xuất"))
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
