import 'package:flutter/material.dart';

class Button01 extends StatelessWidget {
  final Function function;
  final Color color;
  final Color colorText;
  final String title;
  final bool loader;
  const Button01(
      {Key key,
      @required this.function,
      this.color,
      this.colorText,
      @required this.title,
      this.loader = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color =
        this.color == null ? Theme.of(context).primaryColor : this.color;

        Color colorText =
        this.colorText == null ? Colors.white : this.colorText;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
          color: color,
          border: Border.all(width: 3.0, color: color),
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: FlatButton(
        onPressed: function,
        child: this.loader
            ? CircularProgressIndicator(
                strokeWidth: 2.0,
                backgroundColor: Colors.white,
              )
            : Text(
                this.title,
                style: TextStyle(color: colorText, fontSize: 18),
              ),
        color: color,
      ),
    );
  }
}
