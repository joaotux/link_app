import 'package:flutter/material.dart';

class AlertDialogDefault {
  static void show(
      {BuildContext? context,
      String title = "",
      String message = "",
      VoidCallback? function}) {
    showDialog(
        barrierDismissible: false,
        context: context!,
        builder: (_) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: [Text(message)],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Cancelar",
                    style: TextStyle(color: Colors.red),
                  )),
              TextButton(onPressed: function, child: Text("Confirmar"))
            ],
          );
        });
  }
}
