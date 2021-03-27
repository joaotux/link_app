import 'package:flutter/material.dart';
import 'package:link_app/model/Token.dart';
import 'package:link_app/modules/login/login_repository.dart';
import 'package:link_app/modules/login/login_service.dart';
import 'package:link_app/utils/colors_default.dart';
import 'package:link_app/utils/widgets/button01.dart';
import 'package:link_app/utils/widgets/button_link.dart';
import 'package:link_app/utils/widgets/responsive_layout.dart';
import 'package:link_app/utils/widgets/tex_form_fiel01.dart';
import 'package:link_app/utils/widgets/text_form_field_password.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(ColorsDefault.primary),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(top: 150, left: 15, right: 15),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Text(
                          "Gestão Link",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Card(
                        elevation: 3,
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: _formLogin(context),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          ResponsiveLayout.isLargeScreen(context)
              ? Expanded(
                  flex: 2,
                  child: Container(
                      foregroundDecoration: BoxDecoration(
                    image: DecorationImage(
                        alignment: Alignment.centerLeft,
                        image: NetworkImage("assets/images/image.jpg"),
                        fit: BoxFit.fitHeight),
                  )),
                )
              : Container(),
        ],
      ),
    );
  }

  Form _formLogin(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField01(
              hintText: " E-mail",
              controller: _emailController,
              margin: EdgeInsets.only(bottom: 15),
              msgErro: "Informe o e-mail",
            ),
            TextFormFieldPassword(
              hintText: " Senha",
              controller: _passwordController,
              margin: EdgeInsets.only(bottom: 15),
              msgErro: "Informe a senha",
            ),
            Button01(
              function: () async {
                if (_formKey.currentState!.validate()) {
                  String email = _emailController.text;
                  String password = _passwordController.text;

                  await _login(email, password);
                  setState(() {
                    _load = false;
                  });
                }
              },
              title: "Entrar",
              loader: _load,
            ),
            ButtonLink(
              title: "Não tem uma conta? crie uma",
              margin: EdgeInsets.only(top: 15, bottom: 10),
              function: () {
                Navigator.pushNamed(context, "/account_create");
              },
            ),
            ButtonLink(
              title: "Esqueci minha senha",
              function: () {
                Navigator.pushNamed(context, "/forgout_password");
              },
            )
          ],
        ));
  }

  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  var _repository = LoginRepository();
  var _service = LoginService();
  bool _load = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future _login(String email, String password) async {
    setState(() {
      _load = true;
    });
    Token token = await _repository.login(email, password, _scaffoldKey);
    await _service.enterSystem(token, context);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.clear();
    _passwordController.clear();
  }
}
