import 'package:flutter/material.dart';

class TextFormFieldPassword extends StatefulWidget {
  TextEditingController controller;
  String hintText;
  EdgeInsetsGeometry? margin;
  String msgErro;
  FormFieldValidator<String>? validation;

  TextFormFieldPassword(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.margin,
      this.msgErro = "Campo obrigatório",
      this.validation})
      : super(key: key);

  @override
  _TextFormFieldPasswordState createState() => _TextFormFieldPasswordState();
}

bool _passwordVisible = false;

class _TextFormFieldPasswordState extends State<TextFormFieldPassword> {
  @override
  void initState() {
    super.initState();
    widget.margin = widget.margin == null ? EdgeInsets.all(0) : widget.margin;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: TextFormField(
        validator: widget.validation == null
            ? (value) => value!.isEmpty ? widget.msgErro : null
            : widget.validation,
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
