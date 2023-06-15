import 'dart:convert';

import 'package:app_api/services/api/User/getByID.dart';
import 'package:app_api/services/extan/navigitor/pushEXT.dart';
import 'package:app_api/views/Login_screen.dart';
import 'package:app_api/views/signup_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/TextFieldCustom.dart';

class GetScreenID extends StatefulWidget {
  const GetScreenID({super.key});

  @override
  State<GetScreenID> createState() => _GetScreenIDState();
}

class _GetScreenIDState extends State<GetScreenID> {
  Map order = {};
  final TextEditingController idController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        TextFieldCustom(
            controller: idController,
            hint: "enter id",
            label: "ID",
            icon: Icons.insert_drive_file),
        Center(
            child: ElevatedButton(
                onPressed: () async {
                  if (idController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("please enter somthing")));
                  } else {
                    try {
                      if (int.parse(idController.text) is int) {
                        order = json.decode(
                            (await getByID(id: idController.text)).body);
                        print(order);
                        if ((order["data"] as List).isEmpty) {
                          order = {};
                        } else {
                          order = order["data"][0];
                        }

                        setState(() {});
                      }
                    } catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("plase enter correct number")));
                    }
                  }
                },
                child: Text("Get id"))),
        Visibility(
            visible: order.isNotEmpty,
            child: Column(
              children: [
                Text(order["id"].toString()),
                Text(order["title"].toString()),
                Text(order["content"].toString()),
                Text(order["create_at"].toString()),
              ],
            )),
      ]),
    );
  }
}
