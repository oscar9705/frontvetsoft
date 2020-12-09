import 'package:demo/src/model/user_model.dart';
import 'package:demo/src/ui/first_page_ui.dart';
import 'package:demo/src/ui/login_ui.dart';
import 'package:demo/src/ui/pet_add_ui.dart';
import 'package:demo/src/ui/pets_ui.dart';
import 'package:demo/src/ui/user_detail.dart';
import 'package:demo/src/ui/users_ui.dart';
import 'package:demo/src/widget/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: 'login',
      routes: {
        '/': (BuildContext context) => FirstPage(),
        'users': (BuildContext context) => UserPage(),
        'pets': (BuildContext context) => PetPage(),
        'petCreate': (BuildContext context) => PetAdd(),
        'login': (BuildContext context) => Login(),
      },
      //home: Login(title: 'Login'),
    );
  }
}
