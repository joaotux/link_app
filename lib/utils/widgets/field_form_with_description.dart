import 'package:flutter/material.dart';
import 'package:link_app/utils/widgets/tex_form_fiel01.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class FieldFormWithDescription extends StatelessWidget {
  final String description;
  final TextEditingController controller;
  final MaskTextInputFormatter format;
  final double width;
  final int maxLines;
  final EdgeInsetsGeometry margin;
  const FieldFormWithDescription({
    Key key,
    this.description,
    this.controller,
    this.format,
    this.width,
    this.maxLines = 1,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(description),
        Container(
            margin: margin,
            width: width,
            child: TextFormField01(
              controller: controller,
              format: format,
              hintText: "",
              maxLines: maxLines,
            )),
      ],
    );
  }
}
