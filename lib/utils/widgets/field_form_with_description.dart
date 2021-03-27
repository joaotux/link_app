import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:link_app/utils/widgets/tex_form_fiel01.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class FieldFormWithDescription extends StatelessWidget {
  final String description;
  final TextEditingController controller;
  final List<TextInputFormatter>? format;
  final double? width;
  final int maxLines;
  final EdgeInsetsGeometry? margin;
  const FieldFormWithDescription({
    Key? key,
    required this.description,
    required this.controller,
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
        Text(
          description,
          overflow: TextOverflow.ellipsis,
        ),
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
