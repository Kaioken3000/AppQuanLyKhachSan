import 'package:flutter/material.dart';

import '../../modal/user_modal.dart';
import '../../service/user_service.dart';
import 'profile.dart';

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
            title: const Text("User"),
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
          body: FutureBuilder<Users>(
            future: getUserById(userid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Profile(user: snapshot.data!);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ));
  }
}
