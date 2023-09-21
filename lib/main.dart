// import 'package:flutter/material.dart';

// import 'screen/home.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     const appTitle = 'Phòng';
//     WidgetsFlutterBinding.ensureInitialized();
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: appTitle,
//       home: MyHomePage(title: appTitle),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:khachsanb1910261/screen/authScreen/login_screen.dart';
import 'package:khachsanb1910261/screen/myhome.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'screen/authScreen/register.dart';

// Future<void> main() async {
//   runApp(const MyApp());
// }
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userid = prefs.getInt("userid");
  
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: userid == null ? const LoginScreen() : MyHome(userid: userid),
  ));
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'LoginRadius Example',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const LoginScreen(),
//     );
//   }
// }
