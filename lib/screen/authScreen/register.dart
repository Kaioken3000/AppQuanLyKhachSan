import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/api_client.dart';
import '../../utils/validators.dart';
import '../phong/phong_home.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static String id = "register_screen";
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController sdtController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ApiClient _apiClient = ApiClient();
  bool _showPassword = false;

  Future<void> registerUsers() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Processing Data'),
        backgroundColor: Colors.green.shade300,
      ));

      Map<String, dynamic> userData = {
        'email': emailController.text,
        'username': usernameController.text,
        'sdt': sdtController.text,
        'password': passwordController.text,
      };

      dynamic res = await _apiClient.registerUser(userData);

      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      // if (res['ErrorCode'] == null) {
      //   Navigator.push(context,
      //       MaterialPageRoute(builder: (context) => const LoginScreen()));
      // } else {
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     content: Text('Error: ${res['Message']}'),
      //     backgroundColor: Colors.red.shade300,
      //   ));
      // }
      if (res["Message"] == 200) {
        WidgetsFlutterBinding.ensureInitialized();
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setInt("userid", res["user"]["id"]);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PhongHome(userid: res["user"]["id"])));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Error'),
          backgroundColor: Colors.red.shade300,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              width: size.width * 0.85,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //   SizedBox(height: size.height * 0.08),
                    const Center(
                      child: Text(
                        "Đăng ký",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),

                    SizedBox(height: size.height * 0.03),
                    TextFormField(
                      validator: (value) =>
                          Validator.validateEmail(value ?? ""),
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Email",
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    TextFormField(
                      controller: usernameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: "Username",
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    TextFormField(
                      controller: sdtController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Số điện thoại",
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    TextFormField(
                      obscureText: _showPassword,
                      validator: (value) =>
                          Validator.validatePassword(value ?? ""),
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: "Mật khẩu",
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                          child: Icon(
                            _showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                        ),
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.06),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: registerUsers,
                        style: ElevatedButton.styleFrom(
                            primary: Colors.indigo,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15)),
                        child: const Text(
                          "Đăng ký",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen())),
                          child: const Text('Đăng nhập')),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
