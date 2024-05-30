import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:waste_managemet_app/Screens/auth/login.dart';
import 'package:waste_managemet_app/Screens/dashboard_home_about%20page/home_page.dart';
import 'package:waste_managemet_app/Services/db_service.dart';
import 'package:waste_managemet_app/firebase_options.dart';

void main() async {
  //initialize the firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  createDataBase();
  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(), 
        builder: ((context, snapshot) {
          if(snapshot.hasData){
            return const HomePage();
          }else{
            return const Login();
          }
        })
      ),
    );
  }
}
