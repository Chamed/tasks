import 'package:flutter/material.dart';
import 'package:tarefas_app/tiles/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {

  final PageController pageController;

  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {

    Widget _buildDrawerBack() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 50, 50, 50),
            Color.fromARGB(255, 97, 97, 97)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
        )
      ),
    );
    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 18.0, right: 32.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 32.0, 18.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: 200.0,
                      height: 200.0,
                      child: Image(image: AssetImage("images/Citadel_menor.png"))
                    ),
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.list, "Finalizadas", pageController, 0),
              Divider(),
              DrawerTile(Icons.list, "Em execução", pageController, 1),
              Divider(),
              DrawerTile(Icons.list, "Icebox", pageController, 2),
            ],
          ),
        ],
      ),
    );
  }
}
