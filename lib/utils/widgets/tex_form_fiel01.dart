import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormField01 extends StatefulWidget {
  TextEditingController controller;
  TextInputFormatter format;
  String hintText;
  bool obscureText;
  EdgeInsetsGeometry margin;
  String msgErro;
  Function(String value) validation;

  TextFormField01(
      {Key key,
      this.controller,
      @required this.hintText,
      this.format,
      this.obscureText = false,
      this.margin,
      this.msgErro = "Campo obrigatório",
      this.validation})
      : super(key: key);

  @override
  _TextFormField01State createState() => _TextFormField01State();
}

bool _passwordVisible;

class _TextFormField01State extends State<TextFormField01> {
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
      child: TextFormField(
        validator: widget.validation == null
            ? (value) => value.isEmpty ? widget.msgErro : null
            : widget.validation,
        controller: widget.controller,
        inputFormatters: widget.format != null ? [widget.format] : [],
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
