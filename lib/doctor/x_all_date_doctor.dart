// import 'package:clinic_app/components/expanded_widget.dart';
// import 'package:clinic_app/doctor/delay_dailog.dart';
// import 'package:flutter/material.dart';

// class AllDateDoctor extends StatefulWidget {
//   @override
//   _AllDateDoctorState createState() => _AllDateDoctorState();
// }

// class _AllDateDoctorState extends State<AllDateDoctor> {
//   final primary = Color(0xff696b9e);
//   final secondary = Color(0xfff29a94);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: ListView.builder(
//       shrinkWrap: true,
//       // physics: const NeverScrollableScrollPhysics(),
//       itemCount: 3,
//       itemBuilder: (context, int) {
//         return Column(
//           children: <Widget>[
//             Center(
//               child: Text(
//                 "Sunday   25/4/2020",
//                 style: TextStyle(
//                     color: primary, fontWeight: FontWeight.bold, fontSize: 18),
//               ),
//             ),
//             ExpandedWidget(
//               itemCount: 4,
//               header: ListTile(
//                 title: Text(
//                   "Khairy Mohamed",
//                   style: TextStyle(fontSize: 17),
//                 ),
//                 leading: CircleAvatar(
//                   backgroundImage: AssetImage("assets/images/avatar.png"),
//                 ),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     Icon(
//                       Icons.timer,
//                       color: secondary,
//                       size: 20,
//                     ),
//                     SizedBox(
//                       width: 5,
//                     ),
//                     Text("6:30",
//                         style: TextStyle(
//                             color: primary, fontSize: 13, letterSpacing: .3)),
//                   ],
//                 ),
//               ),
//               body: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Divider(
//                     height: 10,
//                     color: Colors.black,
//                   ),
//                   ListTile(
//                     title: Text(
//                       "First Session",
//                       style: TextStyle(
//                           color: primary,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18),
//                     ),
//                     subtitle: Row(
//                       children: <Widget>[
//                         // SizedBox(
//                         //   width: 8,
//                         // ),
//                         Icon(
//                           Icons.date_range,
//                           color: secondary,
//                           size: 20,
//                         ),
//                         SizedBox(
//                           width: 5,
//                         ),
//                         Text("sun 22/3/2020",
//                             style: TextStyle(
//                                 color: primary,
//                                 fontSize: 13,
//                                 letterSpacing: .3)),
//                         SizedBox(
//                           width: 8,
//                         ),
//                         Icon(
//                           Icons.timer,
//                           color: secondary,
//                           size: 20,
//                         ),
//                         SizedBox(
//                           width: 5,
//                         ),
//                         Text("from 6:30 to 6:45",
//                             style: TextStyle(
//                                 color: primary,
//                                 fontSize: 13,
//                                 letterSpacing: .3)),
//                       ],
//                     ),
//                     trailing: GestureDetector(
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: <Widget>[
//                           Icon(
//                             Icons.refresh,
//                             color: secondary,
//                             size: 25,
//                           ),
//                           SizedBox(
//                             height: 5,
//                           ),
//                           Text("Delay",
//                               style: TextStyle(
//                                   color: primary,
//                                   fontSize: 17,
//                                   letterSpacing: .3)),
//                         ],
//                       ),
//                       onTap: () {
//                         // showDialog(
//                         //     context: context,
//                         //     builder: (context) => DelayDailog());
//                       },
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                 ],
//               ),
//             )
//           ],
//         );
//       },
//     ));
//   }
// }
