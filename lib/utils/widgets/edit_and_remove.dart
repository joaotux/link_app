import 'package:flutter/material.dart';

class EditAndRemove extends StatelessWidget {
  const EditAndRemove({
    Key? key,
    required this.functionEdit,
    required this.functionRemove,
  }) : super(key: key);

  final GestureTapCallback functionEdit;
  final GestureTapCallback functionRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: functionEdit,
              child: Icon(
                Icons.edit_sharp,
                color: Colors.blue,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: functionRemove,
              child: Icon(
                Icons.delete_forever_rounded,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
