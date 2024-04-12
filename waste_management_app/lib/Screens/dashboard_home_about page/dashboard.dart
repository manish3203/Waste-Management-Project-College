import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State createState() => _DashBoardState();
}

class _DashBoardState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20, left: 30),
                child: Text(
                  "DashBoard",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Card(
                    shadowColor:Colors.grey,
                    elevation:7,
                    child: Container(
                      height: 100,
                      width: 140,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color.fromRGBO(252, 251, 251, 0.922)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Total Waste Collected",
                                style: GoogleFonts.merriweather(
                                    fontWeight: FontWeight.w400, fontSize: 12)),
                            Text(
                              "13.2 Tons",
                              style: GoogleFonts.merriweather(
                                  fontWeight: FontWeight.w800, fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    shadowColor:Colors.grey,
                    elevation:7,
                    child: Container(
                      height: 100,
                      width: 140,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color.fromRGBO(252, 251, 251, 0.922)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Recycled Items",
                                style: GoogleFonts.merriweather(
                                    fontWeight: FontWeight.w400, fontSize: 12)),
                            Text(
                              "3.7 Tons",
                              style: GoogleFonts.merriweather(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Card(
                    shadowColor:Colors.grey,
                    elevation:7,
                    child: Container(
                      height: 100,
                      width: 140,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color.fromRGBO(252, 251, 251, 0.922)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Trash Bags",
                                style: GoogleFonts.merriweather(
                                    fontWeight: FontWeight.w400, fontSize: 12)),
                            Text(
                              "1.8 Tons",
                              style: GoogleFonts.merriweather(
                                  fontWeight: FontWeight.w800, fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    shadowColor:Colors.grey,
                    elevation:7,
                    child: Container(
                      height: 100,
                      width: 140,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color.fromRGBO(252, 251, 251, 0.922)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Compost Bags",
                                style: GoogleFonts.merriweather(
                                    fontWeight: FontWeight.w400, fontSize: 12)),
                            Text(
                              "6.4 Tons",
                              style: GoogleFonts.merriweather(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  shadowColor: Colors.grey,
                  elevation: 7,
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color:Color.fromRGBO(252, 251, 251, 0.922)
                        
                      ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Bulk Items",
                              style: GoogleFonts.merriweather(
                                  fontWeight: FontWeight.w400, fontSize: 12)),
                          Text(
                            "1.3 Tons",
                            style: GoogleFonts.merriweather(
                                fontWeight: FontWeight.w800, fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                    child: Row(
                      children: [
                        Text(
                          "Last Pickup",
                          style: GoogleFonts.merriweather(
                            color:const Color.fromRGBO(98, 98, 98, 0.929)
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "2 days ago",
                          style: GoogleFonts.merriweather(
                            color:const Color.fromRGBO(98, 98, 98, 0.929)
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                    child: Row(
                      children: [
                        Text(
                          "Next Pickup",
                          style: GoogleFonts.merriweather(
                            color:const Color.fromRGBO(98, 98, 98, 0.929)
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "Tomarrow",
                          style: GoogleFonts.merriweather(
                            color:const Color.fromRGBO(98, 98, 98, 0.929)
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                    child: Row(
                      children: [
                        Text(
                          "Pickup Day",
                          style: GoogleFonts.merriweather(
                            color:const Color.fromRGBO(98, 98, 98, 0.929)
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "Saturday",
                          style: GoogleFonts.merriweather(
                            color:const Color.fromRGBO(98, 98, 98, 0.929)
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
