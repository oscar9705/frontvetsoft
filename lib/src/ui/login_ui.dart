import 'package:demo/src/bloc/login_bloc.dart';
import 'package:demo/src/model/login_model.dart' as LoginModel;
import 'package:demo/src/model/token.model.dart';
import 'package:demo/src/resource/Constants.dart';
import 'package:demo/src/ui/first_page_ui.dart';
import 'package:demo/src/ui/sign_up_ui.dart';
import 'package:demo/src/utils/apiresponse_model.dart';
import 'package:demo/src/utils/errorapiresponse_model.dart';
import 'package:demo/src/widget/background_widget.dart';
import 'package:demo/src/widget/button_blue_widget.dart';
import 'package:demo/src/widget/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginBloc loginBloc;
  bool _obscureText = true;
  LoginModel.Login login = LoginModel.Login(password: '', username: '');
  Token token = Token(username: '', token: '', bearer: '');
  final GlobalKey<FormState> _formLogin = GlobalKey<FormState>();
  final textController = TextEditingController();
  final textControllerPass = TextEditingController();

  @override
  void initState() {
    super.initState();
    loginBloc = LoginBloc(context);
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: GoogleFonts.montserrat(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all(width: 1.5, color: Colors.black87)),
              child: TextFormField(
                validator: (value) =>
                    value.isEmpty ? Constants.requireData : null,
                onSaved: (value) {
                  isPassword ? login.password = value : login.username = value;
                },
                obscureText: title == "Contraseña"
                    ? _obscureText
                    : Constants.falseConstant,
                decoration: InputDecoration(
                    suffixIcon: title == "Contraseña"
                        ? FlatButton(
                            onPressed: _toggle,
                            child: Icon(_obscureText
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined))
                        : null,
                    border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(18))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(19))),
                    fillColor: Colors.white,
                    filled: true),
              ))
        ],
      ),
    );
  }

  void submit() {
    final formLogin = _formLogin.currentState;
    formLogin.save();
    print(login.username);
    print(login.password);

    loginBloc.login(login).then((ApiResponse apiResponse) {
      print(apiResponse.statusResponse);
      if (apiResponse.statusResponse == 200) {
        token = apiResponse.object;
        Navigator.of(context).push(_goHomeTransition());
      } else {
        _formLogin.currentState.setState(() {
          _formLogin.currentState.reset();
        });
      }
      print(token.token);
    });
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('o'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Route _goSignUpTransition() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SignUp(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Route _goLoginTransition() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Login(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Route _goHomeTransition() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => FirstPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(_goSignUpTransition());
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '¿No tienes cuenta?',
              style: GoogleFonts.montserrat(
                  textStyle: Theme.of(context).textTheme.headline4,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.blueGrey[500]),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Registrate',
              style: GoogleFonts.montserrat(
                  textStyle: Theme.of(context).textTheme.headline4,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.blueGrey[900]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        Form(
          key: _formLogin,
          child: Column(
            children: [
              _entryField("Correo"),
              _entryField("Contraseña", isPassword: true),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          BackgroundWidget(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .2),
                  TitleApp(),
                  SizedBox(height: 50),
                  _emailPasswordWidget(),
                  SizedBox(height: 20),
                  ButtonBlue(
                    onTap: submit,
                    texto: 'Iniciar sesión',
                  ),
                  _containerContrasenia(),
                  _divider(),
                  _createAccountLabel(),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Widget _containerContrasenia() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.bottomCenter,
      child: Text('¿Olvidaste tu contraseña?',
          style: GoogleFonts.montserrat(
              textStyle: Theme.of(context).textTheme.headline4,
              fontSize: 12,
              fontWeight: FontWeight.w300,
              color: Colors.black87)),
    );
  }

  @override
  void dispose() {
    super.dispose();
    loginBloc.dispose();
  }
}
