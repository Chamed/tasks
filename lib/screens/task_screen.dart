import 'package:flutter/material.dart';
import 'package:tarefas_app/helpers/task_helper.dart';

class TaskPage extends StatefulWidget {

  final Task task;

  TaskPage({this.task});

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _requesterController = TextEditingController();
  final _ownerController = TextEditingController();

  final _nameFocus = FocusNode();


  bool _userEdited = false;

  Task _editedTask;


  @override
  void initState() {
    super.initState();

    if(widget.task == null){
      _editedTask = Task();
    } else {
      _editedTask = Task.fromMap(widget.task.toMap());

      _nameController.text = _editedTask.name;
      _descController.text = _editedTask.desc;
      _requesterController.text = _editedTask.requester;
      _ownerController.text = _editedTask.owner;


    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 50, 50, 50) ,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 50, 50, 50),
          title: Text(_editedTask.name ?? 'Nova Task'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            if(_editedTask.name.isNotEmpty && _editedTask.name != null){
              Navigator.pop(context, _editedTask);
            }else{
              FocusScope.of(context).requestFocus(_nameFocus);
            }
          },
          child: Icon(Icons.save),
          backgroundColor:  Color.fromARGB(255, 71 ,148 ,87),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _nameController,
                focusNode: _nameFocus,
                decoration: InputDecoration(
                    labelText: "Nome"),
                    cursorColor: Color.fromARGB(255, 71 ,148 ,87),
                onChanged: (text){
                  _userEdited = true;
                  setState((){
                    _editedTask.name = text;
                  });
                }
              ),
              TextField(
                controller: _descController,
                decoration: InputDecoration(labelText: "Descrição"), cursorColor: Color.fromARGB(255, 71 ,148 ,87),
                onChanged: (text){
                  _userEdited = true;
                  _editedTask.desc = text;
                }
              ),
              TextField(
                controller: _requesterController,
                decoration: InputDecoration(labelText: "Solicitante"), cursorColor: Color.fromARGB(255, 71 ,148 ,87),
                onChanged: (text){
                  _userEdited = true;
                  _editedTask.requester = text;
                }
              ),
              TextField(
                controller: _ownerController,
                decoration: InputDecoration(labelText: "Dono"), cursorColor: Color.fromARGB(255, 71 ,148 ,87),
                onChanged: (text){
                  _userEdited = true;
                  _editedTask.owner = text;
                }
              ),
              DropdownButton(
                  items: [
                    DropdownMenuItem<String>(
                      value: "1",
                      child: Text(
                        "Finalizada",
                      ),
                    ),
                    DropdownMenuItem<String>(
                      value: "2",
                      child: Text(
                        "Em andamento",
                      ),
                    ),
                    DropdownMenuItem<String>(
                      value: "3",
                      child: Text(
                        "Icebox",
                      ),
                    ),
                  ],
                onChanged: (value){
                  setState(() {
                  });
                  _userEdited = true;
                  _editedTask.status = value;
                },
                elevation: 1,
                isExpanded: true,
                hint: Text("Status"),
                style: TextStyle(color: Color.fromARGB(255, 71 ,148 ,87), fontSize: 15.0),
                isDense: true,
                iconSize: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
    Future<bool>_requestPop(){
      if(_userEdited){
        showDialog(context: context,
            builder: (context){
              return AlertDialog(
                title: Text("Descartar mudanças?"),
                content: Text("Ao sair todas as mudanças serão perdidas"),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Cancelar'),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                  FlatButton(
                    child: Text('Sair'),
                    onPressed: (){
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            }
        );
      return Future.value(false);
      }else{
      return Future.value(true);
    }
  }
}
