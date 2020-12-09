import 'package:demo/src/bloc/user_bloc.dart';
import 'package:demo/src/model/user_model.dart';
import 'package:demo/src/utils/apiresponse_model.dart';
import 'package:demo/src/widget/profile_widget.dart';
import 'package:demo/src/widget/title_widget.dart';
import 'package:flutter/material.dart';

class UserDetail extends StatefulWidget {
  final int id;
  UserDetail({Key key, this.id}) : super(key: key);

  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  int pruebaId;
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
  Widget build(BuildContext context) {
    print(widget.id);
    return Scaffold(
      appBar: AppBar(
        title: _titulo(),
      ),
      body: Stack(
        children: [
          _fondoApp(),
          _cargarUsuario(userBloc),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    print(pruebaId);
    userBloc = UserBloc();
    userBloc.getUserById(widget.id).then((ApiResponse apiResponse) {
      if (apiResponse.statusResponse == 200) {
        user = apiResponse.object;
      } else {
        print("hay un error");
      }
    });
  }

  Widget _fondoApp() {
    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset(0.0, 0.6),
          end: FractionalOffset(0.0, 1.0),
          colors: [
            Colors.blueGrey[200],
            Colors.lightBlue[100],
          ],
        ),
      ),
    );

    return Stack(
      children: <Widget>[
        gradiente,
      ],
    );
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

  Widget _titulo() {
    return Container(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 30.0),
            TitleApp(),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
