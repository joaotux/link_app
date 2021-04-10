import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:link_app/model/receita_ws.dart';
import 'package:link_app/modules/config/dio_config.dart';
import 'package:link_app/modules/config/dio_error_defalt.dart';
import 'package:link_app/utils/colors_default.dart';
import 'package:link_app/utils/widgets/snackbar_default.dart';

class ReceitaWsRepository {
  Response? response;

  Future<ReceitaWs> findCfpj(String cnpj, GlobalKey<ScaffoldState> key) async {
    ReceitaWs receitaWs = ReceitaWs();
    try {
      response = await DioConfig.getDioWithToken().get("receitaWs/$cnpj");

      if (response!.statusCode == 200) {
        receitaWs = ReceitaWs.fromJson(response!.data);

        if (receitaWs.status == "ERROR") {
          SnackBarDefault.open(
              scaffoldKey: key,
              message: receitaWs.message,
              color: Color(ColorsDefault.alertError),
              colorText: Colors.white);
        }
      } else if (response!.statusCode == 400) {
        SnackBarDefault.open(
            scaffoldKey: key,
            message: response!.statusMessage,
            color: Color(ColorsDefault.alertInfo));
      }
    } on DioError catch (e) {
      DioErrorDefault.show(error: e, scaffoldKey: key);
    }
    return receitaWs;
  }
}
