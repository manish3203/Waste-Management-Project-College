
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:waste_managemet_app/Screens/Maps/maps_page.dart';
import 'package:waste_managemet_app/Screens/dashboard_home_about%20page/about_screen.dart';
import 'package:waste_managemet_app/Screens/dashboard_home_about%20page/dashboard.dart';
import 'package:waste_managemet_app/Screens/realtime%20data/show_data.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;

  int _tapIndex = 0;
  signout() async {
    await FirebaseAuth.instance.signOut();
  }

  // List of widgets for different screens
  List<Widget> widgetList = [
    const DashBoard(),
    const MapWithMarkers(),
    const AboutScreen(),
    const ShowData()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetList[_tapIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: _tapIndex,
        backgroundColor: Colors.black, // Customize background color
        color: Colors.green, // Customize button background color
        buttonBackgroundColor: Colors.white, // Customize button background color
        height: 60, // Customize the height of the navigation bar
        items:const [
          CurvedNavigationBarItem(
            child: Icon(Icons.dashboard, size: 30),
            label: 'Dashboard',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.navigation, size: 30),
            label: 'Maps',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.inbox, size: 30),
            label: 'About',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.history_rounded, size: 30),
            label: 'History',
          ),
        ],
        onTap: (index) {
          setState(() {
            _tapIndex = index;
          });
        },
      ),
    );
  }
}

/*class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;

  int _tapIndex = 0;
  signout() async {
    await FirebaseAuth.instance.signOut();
  }

  //list of widget of screen
  List<Widget> widgetList = [
    const MapWithMarkers(),
    const AboutScreen(),
    const DashBoard(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetList[_tapIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState(() {
            _tapIndex = index;
          });
        },
        currentIndex: _tapIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.navigation),label: 'MAPS'),
          BottomNavigationBarItem(icon: Icon(Icons.inbox),label: 'ABOUT'),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard),label: 'DASHBOARD')
        ]
      ),
    );
  }
}*/



/*

import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';

import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:get/get.dart';
import 'package:to_do_app/Controller/NavBarController.dart';
import 'package:to_do_app/Pages/AddTask.dart';
import 'package:to_do_app/Pages/HomePage.dart';
import 'package:to_do_app/Pages/Task.dart';
import 'package:to_do_app/Pages/dayTask.dart';

  List<TabItem> items = [
  const TabItem(
    icon:Icons.home,
    title: 'Home',
  ),
  const TabItem(
    icon: Icons.date_range_sharp,
    title: 'Date',
   
  ),
  const TabItem(
    icon: Icons.add,
    title: 'Add Task',
  ),
  const TabItem(
    icon: Icons.task,
    title: 'Task',
  ),
  const TabItem(
    icon: Icons.person_2_sharp,
    title: 'profile',
  ),
];


class BottomNavBarState extends StatelessWidget {
  int visit = 0;
  double height = 30;
  Color colorSelect =const Color(0XFF0686F8);
  Color color = const Color(0XFF7AC0FF);
  Color color2 = const Color(0XFF96B1FD);
  Color bgColor = const Color.fromARGB(163, 106, 143, 255);

  List<Widget>widgetList = [const HomePage(),const DayTask(),const CreateTask(),const Task(),const HomePage()];
  NavBarController controller = Get.put(NavBarController());

  BottomNavBarState({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() =>  Scaffold(
      body: widgetList[controller.visit.value],
      bottomNavigationBar: SizedBox(
        child: BottomBarInspiredOutside(
              items: items,
              backgroundColor: bgColor,
              color: const Color(0XFF0686F8),
              colorSelected: Colors.white,
              indexSelected: controller.visit.value,
              onTap: (int index) => controller.visit.value = index,
              top: -28,
              animated: false,
              itemStyle: ItemStyle.circle,
              chipStyle:const ChipStyle(notchSmoothness: NotchSmoothness.sharpEdge),
            ),
        ),
    )
    );
  }
}
*/













      /*appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          title: const Text("HomePage"),
          actions: [
            IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ReadWidget()));
              }, 
              icon: const Icon(Icons.notifications,color: Colors.white,)
            )
          ],
          backgroundColor: const Color.fromARGB(255, 59, 217, 64),
          elevation: 50,
          shadowColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)
            )
          ),
          
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Card(
                  shadowColor: Colors.black,
                  elevation: 10,
                  child: SizedBox(
                    height: 150,
                    width: 150,
                    child: IconButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const MapWithMarkers()));
                      }, 
                      icon: const Icon(
                        Icons.map,
                        color: Colors.blue,
                        size: 70,
                      )
                    )
                  ),
                )
              ],
            )
          ],
        ),
      ),*/
      /*floatingActionButton: FloatingActionButton(
        onPressed: (() => signout()),
        child: const Icon(Icons.login_rounded),
      ),
    );
  }
}
*/