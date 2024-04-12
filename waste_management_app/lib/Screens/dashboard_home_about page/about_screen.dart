import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State createState() => _AboutScreenState();
}

class _AboutScreenState extends State {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(18.0),
          child: Column(
            children:[
              const SizedBox(height: 30),
              Center(
                child: Text(
                  "Poject Name",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 34
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Waste Mangement System",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 23
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: Text(
                  "Team Members",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 34
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.play_circle_filled),
                  Text(
                    "Rohan Chaugule",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 23
                    ),
                  ),
                ],
              ),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.play_circle_filled),
                  Text(
                    "Omkar Kolate    ",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 23
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.play_circle_filled),
                  Text(
                    "Arpit Indurkar    ",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 23
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.play_circle_filled),
                  Text(
                    "Manish Chavan ",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 23
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30),
              Center(
                child: Text(
                  "Project Information",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 34
                  ),
                ),
              ),
              Text(
                "To analyze city’s waste production by combining smart sensor information with an intelligent waste management system.",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20
                  ),
              ),
              const SizedBox(height:30),
              Center(
                child: Text(
                  "Hardware Information",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 32
                  ),
                ),
              ),
            ]
          )
        ),
      )
    );
  }
}
// class _AboutScreenState extends State {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//           padding: const EdgeInsets.all(18.0),
//           child: Center(
//             child: ListView(
//               children: [
//                 SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Column(
//                         children: [
//                           const SizedBox(height: 80),
//                           Card(
//                             shadowColor: Colors.grey,
//                             elevation: 15,
//                             child: SizedBox(
//                               height: 400,
//                               width: 300,
//                               child: Column(
//                                 children: [
//                                   const SizedBox(height: 10),
//                                   const Text(
//                                     "Project Name",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w800,
//                                         fontSize: 24),
//                                   ),
//                                   const Padding(
//                                     padding: EdgeInsets.all(18.0),
//                                     child: Text(
//                                       "Waste Management System",
//                                       style: TextStyle(fontSize: 19),
//                                     ),
//                                   ),
//                                   const Text(
//                                     "Team Members",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w800,
//                                         fontSize: 24),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(18.0),
//                                     child: Column(
//                                       children: [
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceAround,
//                                           children: [
//                                             Container(
//                                               height: 100,
//                                               width: 100,
//                                               decoration: const BoxDecoration(
//                                                   shape: BoxShape.circle,
//                                                   color: Colors.red),
//                                             ),
//                                             Container(
//                                               height: 100,
//                                               width: 100,
//                                               decoration: const BoxDecoration(
//                                                   shape: BoxShape.circle,
//                                                   color: Colors.amber),
//                                             )
//                                           ],
//                                         ),
//                                         const SizedBox(height: 20),
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceAround,
//                                           children: [
//                                             Container(
//                                               height: 100,
//                                               width: 100,
//                                               decoration: const BoxDecoration(
//                                                   shape: BoxShape.circle,
//                                                   color: Colors.red),
//                                             ),
//                                             Container(
//                                               height: 100,
//                                               width: 100,
//                                               decoration: const BoxDecoration(
//                                                   shape: BoxShape.circle,
//                                                   color: Colors.amber),
//                                             )
//                                           ],
//                                         )
//                                       ],
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(width: 10),
//                       const Column(
//                         children: [
//                           SizedBox(height: 80),
//                           Card(
//                             shadowColor: Colors.grey,
//                             elevation: 15,
//                             child: SizedBox(
//                               height: 400,
//                               width: 300,
//                               child: Column(
//                                 children: [
//                                   SizedBox(height: 10),
//                                   Text(
//                                     "Project Information",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w800,
//                                         fontSize: 24),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.all(18.0),
//                                     child: Text(
//                                       "Waste Management System",
//                                       style: TextStyle(fontSize: 19),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(width: 10),
//                       const Column(
//                         children: [
//                           SizedBox(height: 80),
//                           Card(
//                             shadowColor: Colors.grey,
//                             elevation: 15,
//                             child: SizedBox(
//                               height: 400,
//                               width: 300,
//                               child: Column(
//                                 children: [
//                                   SizedBox(height: 10),
//                                    Text(
//                                     "Hardware Information",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w800,
//                                         fontSize: 24),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           )),
//     );
//   }
// }
