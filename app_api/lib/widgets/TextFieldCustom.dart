import 'package:flutter/material.dart';

class TextFieldCustom extends StatefulWidget {
  TextFieldCustom(
      {super.key,
      required this.hint,
      required this.label,
      required this.icon,
      this.isPassword = false,
      this.controller,
      this.onChanged,
      this.obscureText = false,
      this.minLines = 1,
      this.maxLines = 1});

  final String hint;
  final String label;
  final IconData icon;
  final bool? isPassword;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  bool obscureText;
  final int minLines;
  final int maxLines;

  @override
  State<TextFieldCustom> createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        enabled: true,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        controller: widget.controller,
        onChanged: widget.onChanged,
        obscureText: widget.obscureText,
        obscuringCharacter: "*",
        cursorColor: Colors.grey,
        // cursorWidth: 5,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: widget.hint,
            labelText: widget.label,
            prefixIcon: Icon(
              widget.icon,
              color: Colors.green,
            ),
            suffixIcon: widget.isPassword!
                ? IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      widget.obscureText
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        widget.obscureText = !widget.obscureText;
                      });
                    })
                : null,
            labelStyle: const TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.cyanAccent))),
      ),
    );
  }
}
