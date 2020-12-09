import 'package:demo/src/bloc/pet_bloc.dart';
import 'package:demo/src/model/pet_model.dart';
import 'package:demo/src/model/user_model.dart';
import 'package:demo/src/ui/pets_ui.dart';
import 'package:demo/src/utils/apiresponse_model.dart';
import 'package:demo/src/utils/validators_forms.dart';
import 'package:demo/src/widget/background_widget.dart';
import 'package:demo/src/widget/button_blue_widget.dart';
import 'package:demo/src/widget/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

class PetAdd extends StatefulWidget {
  PetAdd({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _PetAddState createState() => _PetAddState();
}

class _PetAddState extends State<PetAdd> {
  String texto;
  final GlobalKey<FormState> _formRegister = GlobalKey<FormState>();
  PetBloc petBloc;
  List<String> _list = List();
  String _opcion;
  Pet pet = Pet(
      idPet: null,
      namePet: '',
      speciePet: '',
      agePet: '',
      breedPet: '',
      sexPet: null,
      observation: '',
      ownerPet: 1,
      statePet: true);

  void _selection(String selectType) {
    setState(() {
      _opcion = selectType;
      String _sexPet;
      if (_opcion == "macho") {
        _sexPet = "macho";
        _list = ['macho', 'hembra'];
        ;
        pet.sexPet = _sexPet;
      }
      if (_opcion == "hembra") {
        _sexPet = "hembra";
        _list = ['hembra', 'macho'];
        ;
        pet.sexPet = _sexPet;
      }

      _opcion = _sexPet;
    });
  }

  @override
  void initState() {
    super.initState();
    lista();
    petBloc = PetBloc();
  }

  List<String> lista() {
    _list = ['macho', 'hembra'];
    return _list;
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Volver',
                style: GoogleFonts.montserrat(
                    textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Colors.black87))
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title) {
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
                validator: (value) {
                  if (title == "Nombre" ||
                      title == "Especie" ||
                      title == "Raza" ||
                      title == "Observacion") {
                    return ValidatorForms.validateLetter(value);
                  }
                  return null;
                },
                onSaved: (value) {
                  setPet(value, title);
                },
                decoration: InputDecoration(
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

  void setPet(String value, String title) {
    if (title == "Nombre") pet.namePet = value;
    if (title == "Especie") pet.speciePet = value;
    if (title == "Raza") pet.breedPet = value;
    if (title == "Observacion") pet.observation = value;
    if (title == "Dueño") pet.ownerPet = int.parse(value);
  }

  Widget _registryBody() {
    return Form(
      key: _formRegister,
      child: Column(
        children: <Widget>[
          _entryField("Nombre"),
          _entryField("Especie"),
          _entryField("Raza"),
          SizedBox(
            height: 20.0,
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Text('Sexo',
                        style: GoogleFonts.montserrat(
                            textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87)),
                    SizedBox(
                      width: 15.0,
                    ),
                    DropdownButton<String>(
                      value: _list[0],
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black87),
                      underline: Container(
                        height: 2,
                        color: Colors.blueGrey[700],
                      ),
                      onChanged: (value) {
                        _opcion = value;
                      },
                      items:
                          _list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          onTap: () {
                            _selection(value);
                          },
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ]),
          SizedBox(
            height: 20.0,
          ),
          _entryField("Observacion"),
          _entryField("Dueño"),
        ],
      ),
    );
  }

  Route _goPetsTransition() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => PetPage(),
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

  void submit() {
    final formRegister = _formRegister.currentState;
    if (formRegister.validate()) {
      formRegister.save();
      print(pet.toJson());
      pet.statePet = true;
      petBloc.createPet(pet).then((ApiResponse resp) {
        if (resp.statusResponse == 200) {
          Pet petPrueba = resp.object;
          print(petPrueba.toJson());
          Navigator.of(context).push(_goPetsTransition());
        }
      });
    }
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
                    SizedBox(
                      height: 50,
                    ),
                    _registryBody(),
                    SizedBox(
                      height: 20,
                    ),
                    ButtonBlue(
                      onTap: submit,
                      texto: 'Registrar Mascota',
                    ),
                    SizedBox(height: height * .14)
                  ],
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    petBloc.dispose();
  }
}
