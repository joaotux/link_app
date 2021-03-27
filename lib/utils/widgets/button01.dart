import 'package:flutter/material.dart';

class Button01 extends StatelessWidget {
  final VoidCallback? function;
  final Color? color;
  final Color? colorText;
  final String title;
  final bool loader;
  final double? width;
  final double? height;
  const Button01(
      {Key? key,
      required this.function,
      this.color,
      this.colorText,
      required this.title,
      this.loader = false,
      this.width,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color =
        (this.color == null ? Theme.of(context).primaryColor : this.color)!;

    Color colorText = this.colorText == null ? Colors.white : this.colorText!;
    double width =
        this.width == null ? MediaQuery.of(context).size.width : this.width!;
    double height = this.height == null ? 50 : this.height!;

    return Container(
      width: width,
      height: height,
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
