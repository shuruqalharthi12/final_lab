import 'package:flutter/material.dart';

extension nav on BuildContext {
  pushAndRemove({required Widget view}) {
    Navigator.push(
      this,
      MaterialPageRoute(builder: (context) => view),
    );
  }
}
