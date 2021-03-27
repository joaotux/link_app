import 'package:flutter/material.dart';

class TextTitle extends StatelessWidget {
  const TextTitle({
    Key? key,
    required this.title,
    required this.context,
  }) : super(key: key);

  final String title;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          color: Theme.of(context).primaryTextTheme.subtitle1!.color,
          fontSize: 25),
    );
  }
}
