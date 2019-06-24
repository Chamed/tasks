import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';


final String taskTable = "taskTable";
final String idColumn = 'idColumn';
final String nameColumn = 'nameColumn';
final String descColumn = 'descColumn';
final String ownerColumn = 'ownerColumn';
final String requesterColumn = 'requesterColumn';
final String statusColumn = 'statusColumn';


class TaskHelper{
  static final TaskHelper _instance = TaskHelper.internal();

  factory TaskHelper() => _instance;

  TaskHelper.internal();

  Database _db;

  Future<Database> get db async{
    if (_db != null){
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "tasks.db");
    
    return openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async{
      await db.execute(
        "CREATE TABLE $taskTable($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $descColumn TEXT,"
            "$ownerColumn TEXT, $requesterColumn TEXT, $statusColumn TEXT)"
      );
    });
  }

  Future<Task>saveTask(Task task) async {
    Database dbTask = await db;
    task.id = await dbTask.insert(taskTable, task.toMap());
    return task;
  }

  Future<Task> getTask(int id) async {
    Database dbTask = await db;
    List<Map> maps = await dbTask.query(taskTable,
      columns: [idColumn, nameColumn, descColumn, requesterColumn, ownerColumn, statusColumn],
      where: "$idColumn = ?",
      whereArgs:  [id]);
    if(maps.length > 0){
      return Task.fromMap(maps.first);
    }else{
      return null;
    }
  }
  Future<int>deleteTask(int id) async{
    Database dbTask = await db;
    return await dbTask.delete(taskTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  updateTask(Task task) async{
    Database dbTask = await db;
    return await dbTask.update(taskTable, task.toMap(), where: "$idColumn = ?", whereArgs: [task.id]);
  }

  Future<List>getAllTasks() async{
    Database dbTask = await db;
    List listMap = await dbTask.rawQuery("SELECT * FROM $taskTable");
    List<Task> listTask = List();
    for (Map x in listMap){
      listTask.add(Task.fromMap(x));
    }
    return listTask;
  }

  Future<List>getAllTasksStatus(status) async{
    Database dbTask = await db;
    List listMap = await dbTask.rawQuery("SELECT * FROM $taskTable WHERE $statusColumn=$status");
    List<Task> listTask = List();
    for (Map x in listMap){
      listTask.add(Task.fromMap(x));
    }
    return listTask;
  }

  Future<int>getHowMany() async {
    Database dbTask = await db;
    return Sqflite.firstIntValue(await dbTask.rawQuery("SELECT COUNT (*) FROM $taskTable"));
  }
  Future close() async{
    Database dbTask = await db;
    dbTask.close();
  }
}

class Task{

  int id;
  String name;
  String desc;
  String owner;
  String requester;
  String status;
  Task();

  Task.fromMap(Map map){
    id = map[idColumn];
    name = map[nameColumn];
    desc = map[descColumn];
    owner = map[ownerColumn];
    requester = map[requesterColumn];
    status = map[statusColumn];
  }
  Map toMap() {
    Map<String, dynamic> map = {
      nameColumn: name,
      descColumn: desc,
      ownerColumn: owner,
      requesterColumn: requester,
      statusColumn: status
    };
    if(id != null){
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Task(id: $id, name: $name, desc: $desc, owner: $owner, requester: $requester, status: $status)";
  }
}