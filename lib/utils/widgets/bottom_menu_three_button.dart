import 'package:flutter/material.dart';
import 'package:link_app/utils/widgets/button01.dart';
import 'package:link_app/utils/widgets/responsive_layout.dart';

class BottomMenuThreeButton extends StatelessWidget {
  const BottomMenuThreeButton(
      {Key? key,
      required bool loaderCreate,
      required VoidCallback this.functionSave,
      required VoidCallback this.functionSaveAndCreateNew})
      : _loaderCreate = loaderCreate,
        super(key: key);

  final bool _loaderCreate;
  final VoidCallback functionSave;
  final VoidCallback functionSaveAndCreateNew;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Color(0xFFd9d9d9),
      height: 80,
      child: Padding(
        padding: EdgeInsets.only(
            left: ResponsiveLayout.isSmallScreen(context)
                ? 15
                : MediaQuery.of(context).size.width * 20 / 100,
            right: ResponsiveLayout.isSmallScreen(context)
                ? 15
                : MediaQuery.of(context).size.width * 20 / 100),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(right: 15),
                  child: Button01(
                      loader: _loaderCreate,
                      function: functionSave,
                      title: "Salvar"),
                )),
            Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.only(right: 15),
                  child: Button01(
                    function: functionSaveAndCreateNew,
                    title: "Salvar e adicionar outro",
                    color: Color(0xFFf2f2f2),
                    colorText: Color(0xFF1a1a1a),
                  ),
                )),
            Expanded(
                flex: 1,
                child: Button01(
                  function: () {
                    Navigator.pop(context);
                  },
                  title: "Listar",
                  color: Color(0xFFf2f2f2),
                  colorText: Color(0xFF0C66BB),
                )),
          ],
        ),
      ),
    );
  }
}
