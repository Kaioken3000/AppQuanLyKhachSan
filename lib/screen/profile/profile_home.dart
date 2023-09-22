import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../modal/user_modal.dart';
import '../../service/user_service.dart';
import '../authScreen/login_screen.dart';
import 'profile.dart';
import 'profile2.dart';

class ProfileHome extends StatelessWidget {
  const ProfileHome({super.key, required this.userid});

  final int userid;

  @override
  Widget build(BuildContext context) {
    const appTitle = 'User';

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appTitle,
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Profile"),
            backgroundColor: Color(0xff006df1),
            elevation: 0,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.logout),
                tooltip: 'User profile',
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
              ),
            ],
          ),
          body: FutureBuilder<Users>(
            future: getUserById(userid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ProfilePage1(user: snapshot.data!);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }
}
