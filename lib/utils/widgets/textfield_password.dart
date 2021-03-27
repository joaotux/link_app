import 'package:flutter/material.dart';

class TextFieldPassword extends StatefulWidget {
  TextEditingController controller;
  String hintText;
  EdgeInsetsGeometry? margin;

  TextFieldPassword(
      {Key? key, required this.controller, required this.hintText, this.margin})
      : super(key: key);

  @override
  _TextFieldPasswordState createState() => _TextFieldPasswordState();
}

bool _passwordVisible = false;

class _TextFieldPasswordState extends State<TextFieldPassword> {
  @override
  void initState() {
    super.initState();
    widget.margin = widget.margin == null ? EdgeInsets.all(0) : widget.margin;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: TextField(
        controller: widget.controller,
        obscureText: !_passwordVisible,
        decoration: InputDecoration(
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey),
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
        ),
      ),
    );
  }
}
