import 'package:flutter/material.dart';

class ButtonLink extends StatelessWidget {
  final String title;
  final GestureTapCallback? function;
  EdgeInsetsGeometry? margin;
  ButtonLink(
      {Key? key, required this.title, required this.function, this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    margin = margin == null ? EdgeInsets.zero : margin;

    return Container(
      margin: margin,
      child: GestureDetector(
        child: Text(this.title),
        onTap: function,
      ),
    );
  }
}
