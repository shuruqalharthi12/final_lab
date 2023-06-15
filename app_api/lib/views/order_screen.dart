import 'package:app_api/services/extan/navigitor/pushEXT.dart';
import 'package:app_api/views/Home_screen.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key, required this.order});

  final Map order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Card(child: Text(order["id"].toString())),
        Text(
          order["title"],
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        Text(
          order["content"],
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        Text(
          order["create_at"],
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            onPressed: () async {
              context.pushAndRemove(view: HomeScreen());
            },
            child: Text("Go back"),
          ),
        )
      ]),
    );
  }
}
