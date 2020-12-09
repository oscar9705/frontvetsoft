import 'package:demo/src/bloc/user_bloc.dart';
import 'package:demo/src/model/user_model.dart';
import 'package:demo/src/utils/apiresponse_model.dart';
import 'package:demo/src/widget/pet_paw_background_widget.dart';
import 'package:demo/src/widget/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstPage extends StatefulWidget {
  FirstPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  UserBloc userBloc;
  User user = User(
      id: null,
      names: '',
      surnames: '',
      documentType: '',
      documentValue: '',
      birthdate: null,
      department: '',
      city: '',
      neighborhood: '',
      telephone: '',
      email: '',
      password: '',
      state: null,
      role: '');

  @override
  void initState() {
    super.initState();
    userBloc = UserBloc();

    userBloc.getUserByEmail().then((ApiResponse apiResponse) {
      if (apiResponse.statusResponse == 200) {
        user = apiResponse.object;
      } else {
        print("hay un error");
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    userBloc.dispose();
  }

  int _selectedIndex = 0;
  List<Widget> _options() {
    return <Widget>[
      //Initial page scaffold
      Text(
        'Inicio',
      ),
      //Apointment scaffold
      Text(
        'Cita',
      ),
      //Profile scaffold
      Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(30, 50, 30, 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Detalles',
                  style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.blueGrey[900]),
                ),
                Container(height: 24, width: 24),
                Text('Cerrar sesión',
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.red[500]))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Stack(fit: StackFit.loose, children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      width: 140.0,
                      height: 140.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: ExactAssetImage('assets/images/user.png'),
                          fit: BoxFit.cover,
                        ),
                      )),
                ],
              ),
            ]),
          ),
          Expanded(
            child: _cargarUsuario(userBloc),
          )
        ],
      )
    ];
  }

  Widget _cargarUsuario(UserBloc userBloc) {
    return StreamBuilder<User>(
      initialData: user,
      stream: userBloc.userStream,
      builder: (context, snapshot) {
        user = snapshot.data;
        return ProfileWidget(user: user);
      },
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Stack(children: <Widget>[
        PetPawBackgroundWidget(),
        Center(
          child: _options().elementAt(_selectedIndex),
        )
      ])),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets_outlined),
            label: 'Cita',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_outlined),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightBlue[600],
        onTap: _onItemTapped,
      ),
    );
  }
}
