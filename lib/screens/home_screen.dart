import 'package:flutter/material.dart';
import 'package:tarefas_app/helpers/task_helper.dart';
import 'package:tarefas_app/screens/task_screen.dart';
import 'package:tarefas_app/tabs/completed_tab.dart';
import 'package:tarefas_app/tabs/execution_tab.dart';
import 'package:tarefas_app/tabs/icebox_tab.dart';
import 'package:tarefas_app/widgets/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageController = PageController();
  TaskHelper helper = TaskHelper();

  List<Task> tasks = List();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: <Widget>[
        Scaffold(
            appBar: AppBar(
                title: Text("Finalizadas"),
                backgroundColor: Color.fromARGB(255, 50, 50, 50),
                centerTitle: true
            ),
            drawer: CustomDrawer(_pageController),
            body: CompletedTab()
        ),
        Scaffold(
            appBar: AppBar(
                title: Text("Em Andamento"),
                backgroundColor: Color.fromARGB(255, 50, 50, 50),
                centerTitle: true
            ),
            drawer: CustomDrawer(_pageController),
            body: ExecutionTab()
        ),
        Scaffold(
            appBar: AppBar(
                title: Text("Icebox"),
                backgroundColor: Color.fromARGB(255, 50, 50, 50),
                centerTitle: true
            ),
            drawer: CustomDrawer(_pageController),
            body: IceboxTab()
        ),
      ],
    );
  }
}