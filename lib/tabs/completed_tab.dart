import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarefas_app/helpers/task_helper.dart';
import 'package:tarefas_app/screens/task_screen.dart';
import 'package:tarefas_app/widgets/custom_drawer.dart';

class CompletedTab extends StatefulWidget {
  @override
  _CompletedTabState createState() => _CompletedTabState();
}

class _CompletedTabState extends State<CompletedTab> {
  final _pageController = PageController();
  TaskHelper helper = TaskHelper();

  List<Task> tasks = List();

  @override
  void initState() {
    super.initState();

    _getAllTasksStatus();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: <Widget>[
        Scaffold(
          drawer: CustomDrawer(_pageController),
          backgroundColor: Color.fromARGB(255, 50, 50, 50),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _showTaskPage();
            },
            child: Icon(Icons.add),
            backgroundColor: Color.fromARGB(255, 71, 148, 87),
          ),
          body: ListView.builder(
            padding: EdgeInsets.all(10.0),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return _taskCard(context, index);
            },
          ),
        )
      ],
    );
  }

  Widget _taskCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        color: Color.fromARGB(255, 50, 50, 50),
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(tasks[index].name ?? "",
                        style: TextStyle(fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 220, 220, 220))
                    ),
                    Text('Solicitante: ' + tasks[index].requester ?? "",
                        style: TextStyle(fontSize: 15.0,
                            color: Color.fromARGB(255, 71, 148, 87))
                    ),
                    Text('Dono: ' + tasks[index].owner ?? "",
                        style: TextStyle(fontSize: 15.0,
                            color: Color.fromARGB(255, 126, 174, 130))
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        _showOptions(context, index);
      },
    );
  }

  void _showOptions(BuildContext context, int index){
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: (){},
            builder: (context){
              return Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FlatButton(
                        child: Text("Visualizar",
                            style: TextStyle(
                                fontSize: 20.0)
                        ),
                        onPressed: (){
                          Navigator.pop(context);
                          _showTaskPage(task: tasks[index]);
                        }
                    ),
                    FlatButton(
                      child: Text("Excluir",
                          style: TextStyle(
                              fontSize: 20.0)
                      ),
                      onPressed: (){{
                        showDialog(context: context,
                          builder: (context){
                            return AlertDialog(
                              title: Text("Deseja excluir permanentemente essa Task?"),
                              content: Text("Ao aceitar todos os registros serão perdidos"),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Cancelar'),
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                ),
                                FlatButton(
                                  child: Text('Sim'),
                                  onPressed: (){
                                    Navigator.pop(context);
                                    helper.deleteTask(tasks[index].id);
                                    setState(() {
                                      tasks.removeAt(index);
                                      Navigator.pop(context);
                                    });
                                  },
                                )
                              ],
                            );
                          }
                        );
                      }
                    }
                  ),
                ],
              ),
            );
          },
        );
      }
    );
  }

  void _showTaskPage({Task task}) async {
    final recTask = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => TaskPage(task: task,))
    );
    if(recTask != null){
      if(task != null){
        await helper.updateTask(recTask);
      }else{
        await helper.saveTask(recTask);
      }
      _getAllTasksStatus();
    }
  }
  void _getAllTasksStatus(){
    helper.getAllTasksStatus(1).then((list){
      setState(() {
        tasks = list;
      });
    });
  }
}

