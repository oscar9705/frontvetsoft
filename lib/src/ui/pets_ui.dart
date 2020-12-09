import 'package:demo/src/bloc/pet_bloc.dart';
import 'package:demo/src/model/pet_model.dart';
import 'package:demo/src/widget/title_widget.dart';
import 'package:flutter/material.dart';

class PetPage extends StatefulWidget {
  PetPage({Key key}) : super(key: key);
  @override
  _PetPageState createState() => _PetPageState();
}

class _PetPageState extends State<PetPage> {
  PetBloc petBloc;

  @override
  void initState() {
    super.initState();
    petBloc = PetBloc();
    _loadPets();
  }

  void _loadPets() {
    petBloc.initializeData().then((value) => print(value.object));
  }

  ListView _pets(List<Pet> pets) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Container(
            child: Column(
          children: [
            ListTile(
              title: Text(pets[index].namePet),
              subtitle:
                  Text(pets[index].speciePet + " " + pets[index].breedPet),
              leading: Icon(Icons.pets),
            ),
            Divider(),
          ],
        ));
      },
      itemCount: pets.length,
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
          StreamBuilder<List<Pet>>(
            initialData: [],
            stream: petBloc.petList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print("streamBuilders " + snapshot.data.toString());
                return _pets(snapshot.data);
              } else {}
            },
          ),
        ],
      ),
      bottomNavigationBar: _bottomNavigationBar(context),
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

  Widget _bottomNavigationBar(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
            canvasColor: Color.fromRGBO(1, 87, 155, 0.7),
            primaryColor: Color.fromRGBO(83, 221, 205, 0.8),
            textTheme: Theme.of(context).textTheme.copyWith(
                caption: TextStyle(color: Color.fromRGBO(207, 216, 220, 1.0)))),
        child: BottomNavigationBar(
          onTap: (value) => Navigator.pushNamed(context, 'petCreate'),
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                size: 30.0,
              ),
              label: "Añadir",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.pets_sharp,
                size: 30.0,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.logout,
                size: 30.0,
              ),
              label: "Salir",
            ),
          ],
        ));
  }

  @override
  void dispose() {
    super.dispose();
    petBloc.dispose();
  }
}
