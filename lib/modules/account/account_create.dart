import 'package:flutter/material.dart';
import 'package:link_app/model/Token.dart';
import 'package:link_app/model/company.dart';
import 'package:link_app/model/user.dart';
import 'package:link_app/modules/account/account_repository.dart';
import 'package:link_app/modules/login/login_repository.dart';
import 'package:link_app/modules/login/login_service.dart';
import 'package:link_app/utils/colors_default.dart';
import 'package:link_app/utils/string_utils.dart';
import 'package:link_app/utils/widgets/button01.dart';
import 'package:link_app/utils/widgets/responsive_layout.dart';
import 'package:link_app/utils/widgets/tex_form_fiel01.dart';
import 'package:link_app/utils/widgets/text_form_field_password.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AccountCreate extends StatefulWidget {
  AccountCreate({Key? key}) : super(key: key);

  @override
  _AccountCreateState createState() => _AccountCreateState();
}

class _AccountCreateState extends State<AccountCreate> {
  var _email01Controller = TextEditingController();
  var _email02Controller = TextEditingController();
  var _password01Controller = TextEditingController();
  var _password02Controller = TextEditingController();
  var _phoneController = MaskTextInputFormatter(
      mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});

  var _repository = AccountRepository();
  var _loginRepository = LoginRepository();
  var _loginService = LoginService();

  var _globalKey = GlobalKey<ScaffoldState>();
  var _key = GlobalKey<FormState>();
  var _loader = false;

  var _info1;
  var _info2;

  DropdownMenuItem _getDropMenu(String value) {
    return DropdownMenuItem(
      value: value,
      child: Text(
        value,
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Future _create(Company company) async {
    company = await _repository.create(company, _globalKey);

    String email = _email01Controller.text;
    String password = _password01Controller.text;

    if (company.id != null) {
      Token token = await _loginRepository.login(email, password, _globalKey);
      _loginService.enterSystem(token, context);
    }

    setState(() {
      _loader = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.all(15),
            width: ResponsiveLayout.isLargeScreen(context)
                ? ((MediaQuery.of(context).size.width * 25) / 100)
                : MediaQuery.of(context).size.width - 20,
            padding: EdgeInsets.all(15),
            alignment: Alignment.center,
            child: Form(
                key: _key,
                child: Column(
                  children: [
                    Text(
                      "Queremos saber mais sobre você",
                      style: TextStyle(
                          fontSize: 22, color: Color(ColorsDefault.primary)),
                    ),
                    Text(
                      "Preencha os dados abaixo para realizar o seu cadastro:",
                      style: TextStyle(fontSize: 15, color: Color(0xFF424242)),
                    ),
                    TextFormField01(
                      hintText: " E-mail",
                      controller: _email01Controller,
                      margin: EdgeInsets.only(top: 6, bottom: 6),
                      validation: (value) {
                        if (value!.isEmpty) {
                          return "Campo obrigatório";
                        } else if (!StringUtils.isEmail(value)) {
                          return "Formato de e-mail inválido";
                        }
                        return null;
                      },
                    ),
                    TextFormField01(
                        hintText: " Repetir e-mail",
                        controller: _email02Controller,
                        margin: EdgeInsets.only(bottom: 6),
                        validation: (value) {
                          if (value!.isEmpty) {
                            return "Campo obrigatório";
                          } else if (value != _email01Controller.text) {
                            return "E-mails não são iguais";
                          }
                          return null;
                        }),
                    TextFormFieldPassword(
                        hintText: " Senha",
                        controller: _password01Controller,
                        margin: EdgeInsets.only(bottom: 6)),
                    TextFormFieldPassword(
                        hintText: " Repetir senha",
                        controller: _password02Controller,
                        margin: EdgeInsets.only(bottom: 6),
                        validation: (value) {
                          if (value!.isEmpty) {
                            return "Campo obrigatório";
                          } else if (value != _password01Controller.text) {
                            return "Senhas não são iguais";
                          }
                          return null;
                        }),
                    TextFormField01(
                        hintText: " Telefone",
                        format: [_phoneController],
                        margin: EdgeInsets.only(bottom: 6),
                        validation: (value) {
                          if (value!.isEmpty) {
                            return "Campo obrigatório";
                          }
                          return null;
                        }),
                    ButtonTheme(
                        alignedDropdown: true,
                        padding: EdgeInsets.zero,
                        child: DropdownButtonHideUnderline(
                            child: Container(
                          margin: EdgeInsets.only(bottom: 6),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                  style: BorderStyle.solid),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                          ),
                          child: DropdownButton<dynamic>(
                              isExpanded: true,
                              dropdownColor: Color(0xFFFFE1CD),
                              elevation: 0,
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black,
                              ),
                              underline: Container(),
                              hint: Text("Você já tem empresa formalizada?"),
                              value: _info1,
                              items: [
                                _getDropMenu("Sim, de serviços"),
                                _getDropMenu("Sim, de varejo"),
                                _getDropMenu("Sim, uma industria"),
                                _getDropMenu("Sim, sou MEI"),
                                _getDropMenu("Não"),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _info1 = value;
                                });
                              }),
                        ))),
                    ButtonTheme(
                        alignedDropdown: true,
                        padding: EdgeInsets.zero,
                        child: DropdownButtonHideUnderline(
                            child: Container(
                          margin: EdgeInsets.only(bottom: 15),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                  style: BorderStyle.solid),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                          ),
                          child: DropdownButton<dynamic>(
                              isExpanded: true,
                              dropdownColor: Color(0xFFFFE1CD),
                              elevation: 0,
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black,
                              ),
                              underline: Container(),
                              hint: Text("Como você conheceu a Gestão Link?"),
                              value: _info2,
                              items: [
                                _getDropMenu("Anúncio de TV ou Rádio"),
                                _getDropMenu("Busca na internet"),
                                _getDropMenu(
                                    "Influenciadores ou Redes Sociais"),
                                _getDropMenu("Indicação de alguém"),
                                _getDropMenu("Anúncios na Internet"),
                                _getDropMenu(
                                    "Contato de um dos nossos consultores"),
                                _getDropMenu("Outro"),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _info2 = value;
                                });
                              }),
                        ))),
                    Button01(
                      title: "Testar por 7 dias grátis",
                      function: () async {
                        if (_key.currentState!.validate()) {
                          String email = _email01Controller.text;
                          String password = _password01Controller.text;
                          String phone = _phoneController.getMaskedText();

                          var user =
                              User(email: email, password: password, number: 1);

                          Company company = Company(
                              info1: _info1,
                              info2: _info2,
                              phone: phone,
                              identificationType: "CNPJ",
                              users: [user]);

                          setState(() {
                            _loader = true;
                          });
                          await _create(company);
                        }
                      },
                      loader: _loader,
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _email01Controller.clear();
    _email02Controller.clear();
    _password01Controller.clear();
    _password02Controller.clear();
  }
}
