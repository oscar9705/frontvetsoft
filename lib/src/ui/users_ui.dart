import 'package:demo/src/bloc/user_bloc.dart';
import 'package:demo/src/model/user_model.dart';
import 'package:demo/src/widget/title_widget.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  UserBloc userBloc;

  @override
  void initState() {
    super.initState();
    userBloc = UserBloc();
    _loadUsers();
  }

  void _loadUsers() {
    userBloc.initializeData().then((value) => print(value.object));
  }

  ListView _users(List<User> users) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Container(
            child: Column(
          children: [
            ListTile(
              title: Text(users[index].names + " " + users[index].surnames),
              subtitle: Text(users[index].role),
              leading: Icon(Icons.account_box),
            ),
            Divider(),
          ],
        ));
      },
      itemCount: users.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _titulo(),
      ),
      body: Stack(
        children: [
          _fondoApp(),
          StreamBuilder<List<User>>(
            initialData: [],
            stream: userBloc.userList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print("streamBuilders " + snapshot.data.toString());
                return _users(snapshot.data);
              } else {}
            },
          ),
        ],
      ),
    );
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

  @override
  void dispose() {
    super.dispose();
    userBloc.dispose();
  }
}
