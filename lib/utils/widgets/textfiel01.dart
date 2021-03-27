import 'package:flutter/material.dart';

class TextField01 extends StatefulWidget {
  TextEditingController controller;
  String hintText;
  bool obscureText;
  EdgeInsetsGeometry? margin;
  ValueChanged<String>? function;

  TextField01(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.obscureText = false,
      this.margin,
      this.function})
      : super(key: key);

  @override
  _TextField01State createState() => _TextField01State();
}

late bool _passwordVisible;

class _TextField01State extends State<TextField01> {
  @override
  void initState() {
    super.initState();
    _passwordVisible = widget.obscureText ? false : true;
    widget.margin = widget.margin == null ? EdgeInsets.all(0) : widget.margin;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: TextField(
        onChanged: widget.function,
        controller: widget.controller,
        obscureText: !_passwordVisible,
        decoration: InputDecoration(
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey),
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                )
              : Text(""),
        ),
      ),
    );
  }
}
