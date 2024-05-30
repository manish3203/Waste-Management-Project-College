
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:waste_managemet_app/models/real_time_model.dart';

dynamic database;

//create database
void createDataBase() async{
  print("db created");
  database = await openDatabase(
    join(await getDatabasesPath(), "db19.db"),
    version: 1,
    onCreate: (db, version) {
      return db.execute(
        '''CREATE TABLE REALTIMEDATA(
          dustbinId TEXT PRIMARY KEY,
          dustbinLevel INT,
          dustbinMsg Text
        )'''
      );
    }
  );
}


//insert data
Future insertRealTimeData(RealTimeDataModel obj) async{
  print("call insert");
  final localDB = await database;

  await localDB.insert(
    "REALTIMEDATA",
    obj.toStoreData(),
    conflictAlgorithm:ConflictAlgorithm.replace
  );
}


//fetch data
Future getRealTimeData() async{
  print("call fetch");

  final localDB = await database;

  //await the result of query method
  List<Map<String, dynamic>> queryList = await localDB.query("REALTIMEDATA");
  //fetch data in these list
  List<RealTimeDataModel> fetchData = [];

  for(int i=0; i<queryList.length; i++) {
    fetchData.add(
      RealTimeDataModel(
        dustbinId: queryList[i]['dustbinId'],
        dustbinLevel: queryList[i]['dustbinLevel'],
        dustbinMsg: queryList[i]['dustbinMsg']
      )
    );
  }
  return fetchData;

}