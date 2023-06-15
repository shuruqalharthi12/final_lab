import 'dart:convert';

import 'package:app_api/services/api/User/create_order.dart';
import 'package:app_api/services/api/User/get_orders.dart';
import 'package:app_api/services/extan/navigitor/pushEXT.dart';
import 'package:app_api/views/GetID_screen.dart';
import 'package:app_api/views/Login_screen.dart';
import 'package:app_api/views/order_screen.dart';
import 'package:app_api/views/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../widgets/CardOrders.dart';
import '../widgets/TextFieldCustom.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  bool isloading = false;
  List listOrders = [];
  @override
  void initState() {
    super.initState();
    _test();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pushAndRemove(view: LoginScreen());
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                context.pushAndRemove(view: GetScreenID());
              },
              icon: Icon(Icons.move_down))
        ],
      ),
      body: ListView(
        children: [
          TextFieldCustom(
            hint: "Title",
            label: "Title",
            controller: titleController,
            icon: Icons.read_more,
          ),
          TextFieldCustom(
              minLines: 3,
              maxLines: 10,
              hint: "content",
              label: "content",
              controller: contentController,
              icon: Icons.content_copy),
          Center(
              child: ElevatedButton(
            child: Text("GetData"),
            onPressed: () async {
              final result = await createOrder(context: context, body: {
                "title": titleController.text,
                "content": contentController.text
              });

              print(result.statusCode);
              _test();
            },
          )),
          //-------------- display orders ---------------
          if (!isloading) lodingPage(context: context),

          for (var item in listOrders.reversed)
            InkWell(
                onTap: () {
                  context.pushAndRemove(view: OrderScreen(order: item));
                },
                child: CardOrders(order: item)),
        ],
      ),
    );
  }

  _test() async {
    if ((await getOrders()).statusCode == 200) {
      listOrders = json.decode((await getOrders()).body)["data"];
      //print(listOrders);
      isloading = true;
      setState(() {});
    } else {
      final box = GetStorage();
      box.remove("token");
      context.pushAndRemove(view: LoginScreen());
    }
  }
}

lodingPage({required BuildContext context}) {
  return const CircularProgressIndicator();
}

getData({required String keyUser}) {
  final box = GetStorage();
  if (box.hasData(keyUser)) {
    return box.read(keyUser);
  } else {
    return null;
  }
}

getDataWithLoading({required BuildContext context, required String keyUser}) {
  lodingPage(context: context);
  final data = getData(keyUser: keyUser);

  if (data != null) {
    Navigator.of(context).pop();
  }
}
