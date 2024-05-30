
import 'package:waste_managemet_app/Services/db_service.dart';

class RealTimeDataModel {
  String dustbinId;
  int dustbinLevel;
  String dustbinMsg;

  RealTimeDataModel({required this.dustbinId, required this.dustbinLevel, required this.dustbinMsg});

  Map<String, dynamic> toStoreData() {
    print(getRealTimeData());
    print("$dustbinId, $dustbinLevel, $dustbinMsg");
    return {
      "dustbinId":dustbinId,
      "dustbinLevel":dustbinLevel,
      "dustbinMsg":dustbinMsg
    };
  }

  @override
  String toString() {
    return '{dustbinId:$dustbinId, dustbinLevel:$dustbinLevel, dustbinMsg:$dustbinMsg}';
  }
}