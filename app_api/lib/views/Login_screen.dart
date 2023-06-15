import 'dart:convert';

import 'package:app_api/services/api/Auth/login.dart';
import 'package:app_api/services/extan/navigitor/pushEXT.dart';
import 'package:app_api/views/Home_screen.dart';
import 'package:app_api/views/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../widgets/LabelScreen.dart';
import '../widgets/TextFieldCustom.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(children: [
                SizedBox(
                  height: 150,
                ),
                LabelScreen(
                  title: "Log In",
                ),
                TextFieldCustom(
                  hint: "example@gmail.com",
                  label: "Email",
                  icon: Icons.email,
                  controller: emailController,
                ),
                TextFieldCustom(
                  hint: "******",
                  label: "Password",
                  icon: Icons.email,
                  isPassword: true,
                  controller: passwordController,
                ),
                Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        onPressed: () async {
                          final Map body = {
                            "email": emailController.text,
                            "password": passwordController.text,
                          };
                          final response = await loginUser(body: body);
                          print(response.statusCode);
                          print(response.body);

                          if (response.statusCode == 200) {
                            final box = GetStorage();
                            box.write("token",
                                json.decode(response.body)["data"]["token"]);

                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                                (route) => false);
                          }
                        },
                        child: Text("Create"))),
                TextButton(
                  onPressed: () {
                    context.pushAndRemove(view: SignUpScreen());
                  },
                  child: Text(
                    "Don't have an account? signup",
                    style: TextStyle(color: Color.fromARGB(255, 10, 22, 15)),
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
