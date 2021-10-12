// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
//   final double expandedHeight;
//   final bool hideTitleWhenExpanded;

//   CustomSliverDelegate({
//     @required this.expandedHeight,
//     this.hideTitleWhenExpanded = true,
//   });

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     final appBarSize = expandedHeight - shrinkOffset;
//     final cardTopPosition = expandedHeight / 2 - shrinkOffset;
//     final proportion = 2 - (expandedHeight / appBarSize);
//     final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
//     return SizedBox(
//       height: expandedHeight + expandedHeight / 2,
//       child: Stack(
//         children: [
//           SizedBox(
//             height: appBarSize < kToolbarHeight ? kToolbarHeight : appBarSize,
//             child: AppBar(
//               backgroundColor: Colors.deepOrange,
//               elevation: 0.0,
//               title: Opacity(
//                   opacity: hideTitleWhenExpanded ? 1.0 - percent : 1.0,
//                   child: Text("Welcome")),
//             ),
//           ),
//           Positioned(
//             left: 0.0,
//             right: 0.0,
//             top: cardTopPosition > 0 ? cardTopPosition : 0,
//             bottom: 0.0,
//             child: Opacity(
//               opacity: percent,
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 30 * percent),
//                 child: Card(
//                   elevation: 20.0,
//                   child: Column(
//                     children: <Widget>[
//                       SizedBox(height: 10,),
//                       _buildHeader(),
//                     ],
//                   )
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   double get maxExtent => expandedHeight + expandedHeight / 2;

//   @override
//   double get minExtent => kToolbarHeight;

//   @override
//   bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
//     return true;
//   }

//   Row _buildHeader() {
//     return Row(
//       children: <Widget>[
//         SizedBox(width: 20.0),
//         Container(
//             width: 80.0,
//             height: 80.0,
//             child: CircleAvatar(
//                 radius: 40,
//                 backgroundColor: Colors.grey,
//                 child: CircleAvatar(
//                     radius: 35.0,
//                     backgroundImage: AssetImage("assets/images/avatar.png")))),
//         SizedBox(width: 20.0),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               "DR/Mahmoud Shaker",
//               style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10.0),
//             Text("Dietician and Obesity"),
//             SizedBox(height: 5.0),
//             Row(
//               children: <Widget>[
//                 Icon(
//                   FontAwesomeIcons.locationArrow,
//                   size: 12.0,
//                   color: Colors.black54,
//                 ),
//                 SizedBox(width: 10.0),
//                 Text(
//                   "Any Where",
//                   style: TextStyle(color: Colors.black54),
//                 ),
//               ],
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }
