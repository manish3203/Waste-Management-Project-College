
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:waste_managemet_app/Services/db_service.dart';
import 'package:waste_managemet_app/models/real_time_model.dart';

class ShowData extends StatefulWidget {
  const ShowData({Key? key}) : super(key: key);

  @override
  State<ShowData> createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  
  Future<void> _refreshMode() {

    return Future.delayed(const Duration(seconds: 5),(){
      setState(() {
      
    });
    });
  }
  List<RealTimeDataModel> fetchDataList = [];
  @override
  void initState() {
    super.initState();
    _fetchDataFromSQFlite();
  }
  Future _fetchDataFromSQFlite() async{
    fetchDataList = await getRealTimeData();
  }

  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref().child('Global Messages');

  // Define thresholds for different fill levels of the dustbin
  static const int mediumThreshold = 75;
  static const int highThreshold = 90;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("History",
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: _databaseReference.onValue,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else {
            final data = snapshot.data!.snapshot;
            if (!data.exists) {
              return const Center(
                child: Text("No Data Available"),
              );
            } else {
              final level = (data.value as Map<dynamic, dynamic>)["level"] as int? ?? 0;
              final id = (data.value as Map<dynamic, dynamic>)["id"] as String? ?? '';
              
              return _buildDashboard(level, id);
            }
          }
        },
      ),
    );
  }

  Widget _buildDashboard(int level, String id) {
    Color indicatorColor = Colors.green;
    String alertMessage = "Dustbin is partially filled.";

    // Determine the state of the dustbin based on the fill level
    if (level >= highThreshold) {
      indicatorColor = Colors.red;
      alertMessage = "Alert: Dustbin is nearly full!";
    } else if (level >= mediumThreshold) {
      indicatorColor = Colors.orange;
      alertMessage = "Alert: Dustbin is filling up.";
    }
    RealTimeDataModel obj = RealTimeDataModel(
      dustbinId: id, 
      dustbinLevel: level, 
      dustbinMsg: alertMessage
    );
    insertRealTimeData(obj);
    _fetchDataFromSQFlite();
    

    return Padding(
      padding: const EdgeInsets.all(18.0),
      child:RefreshIndicator(
        onRefresh: _refreshMode,
        child: ListView.separated(
          itemCount: fetchDataList.length,
          separatorBuilder: (context, index) {
            return const SizedBox(height: 10);
          },
          itemBuilder: (context, index) { 
            return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(1, 3),
                    color: Colors.grey.withOpacity(0.4),
                    blurRadius: 8
                  )
                ]
              ),
              child: SizedBox(
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      "Dustbin ID: ${fetchDataList[index].dustbinId}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    Text(
                      "Dustbin Level: ${fetchDataList[index].dustbinLevel}%",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Message: ${fetchDataList[index].dustbinMsg}%",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    LinearProgressIndicator(
                      value: level / 100,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
                    ),
                  ],
                ),
              ),
            );
          }),
      )
    );
  }
}