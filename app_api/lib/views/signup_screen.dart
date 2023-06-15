import 'package:app_api/services/api/Auth/createUser.dart';
import 'package:app_api/services/extan/navigitor/pushEXT.dart';
import 'package:app_api/views/Login_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/LabelScreen.dart';
import '../widgets/TextFieldCustom.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  String username = "";
  String password = "";

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
              child: ListView(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  const LabelScreen(title: "Sign up"),
                  TextFieldCustom(
                    hint: "user123",
                    label: "User name",
                    icon: Icons.person,
                    onChanged: (value) {
                      print(value);
                      username = value;
                    },
                  ),
                  TextFieldCustom(
                    hint: "Fahad Alazmi",
                    label: "Name",
                    icon: Icons.email,
                    controller: nameController,
                  ),
                  TextFieldCustom(
                    hint: "example@gmail.com",
                    label: "Email",
                    icon: Icons.email,
                    controller: emailController,
                  ),
                  TextFieldCustom(
                    hint: "AAaa1100229933",
                    label: "password",
                    icon: Icons.email,
                    obscureText: true,
                    isPassword: true,
                    onChanged: (pass) {
                      password = pass;
                    },
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                          onPressed: () async {
                            final Map body = {
                              "email": emailController.text,
                              "password": password,
                              "username": username,
                              "name": nameController.text
                            };
                            final response = await createUser(body: body);
                            print(response.body);
                            if (response.statusCode == 200) {
                              context.pushAndRemove(view: LoginScreen());
                            }
                          },
                          child: Text("Create"))),
                  TextButton(
                    onPressed: () {
                      context.pushAndRemove(view: LoginScreen());
                    },
                    child: Text(
                      "Go Back",
                      style: TextStyle(color: Color.fromARGB(255, 10, 22, 15)),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
