import 'package:flutter/material.dart';
import 'package:link_app/model/Token.dart';
import 'package:link_app/modules/account/account_create.dart';
import 'package:link_app/modules/forgout_password/forgout_password_page.dart';
import 'package:link_app/modules/login/login_repository.dart';
import 'package:link_app/modules/login/login_service.dart';
import 'package:link_app/utils/colors_default.dart';
import 'package:link_app/utils/widgets/button01.dart';
import 'package:link_app/utils/widgets/button_link.dart';
import 'package:link_app/utils/widgets/tex_form_fiel01.dart';
import 'package:link_app/utils/widgets/text_form_field_password.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  var _repository = LoginRepository();
  var _service = LoginService();
  bool _load = false;
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();

  Future _login(String email, String password) async {
    setState(() {
      _load = true;
    });
    Token token = await _repository.login(email, password, _scaffoldKey);
    await _service.enterSystem(token, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(ColorsDefault.primary),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 150,
                alignment: Alignment.center,
                child: Image.asset("assets/icon.png")),
            Card(
              margin: EdgeInsets.only(left: 20, right: 20),
              elevation: 3,
              child: Container(
                padding: EdgeInsets.all(15),
                child: _formLogin(context),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(ColorsDefault.primary),
        elevation: 0,
        child: Text(
          "by UmDesenvolvedor",
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
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
              margin: EdgeInsets.only(bottom: 6),
              msgErro: "Informe o e-mail",
            ),
            TextFormFieldPassword(
              hintText: " Senha",
              controller: _passwordController,
              margin: EdgeInsets.only(bottom: 6),
              msgErro: "Informe a senha",
            ),
            Button01(
              function: () async {
                if (_formKey.currentState.validate()) {
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

  @override
  void dispose() {
    super.dispose();
    _emailController = null;
    _passwordController = null;
  }
}
