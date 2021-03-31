import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormField01 extends StatefulWidget {
  TextEditingController? controller;
  List<TextInputFormatter>? format;
  String hintText;
  bool obscureText;
  int maxLines;
  EdgeInsetsGeometry? margin;
  String msgErro;
  FormFieldValidator<String>? validation;
  bool mandatory;

  TextFormField01(
      {Key? key,
      this.controller,
      required this.hintText,
      this.format,
      this.obscureText = false,
      this.maxLines = 1,
      this.margin,
      this.msgErro = "Campo obrigatório",
      this.validation,
      this.mandatory = false})
      : super(key: key);

  @override
  _TextFormField01State createState() => _TextFormField01State();
}

late bool _passwordVisible;

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
        validator: widget.mandatory
            ? widget.validation == null
                ? (value) => value!.isEmpty ? widget.msgErro : null
                : widget.validation
            : null,
        controller: widget.controller,
        maxLines: widget.maxLines,
        inputFormatters: widget.format != null ? widget.format : [],
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
