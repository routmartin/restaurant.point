// // _requestOutletArea_________________________________________
// _requestLocationCurrently() async {
//   WidgetsBinding.instance.addPostFrameCallback((_) async {
//     showGeneralDialog(
//       barrierColor: Colors.black.withOpacity(0.9),
//       transitionDuration: Duration(milliseconds: 200),
//       barrierDismissible: true,
//       barrierLabel: '',
//       context: context,
//       pageBuilder: (context, animation1, animation2) {
//         return null;
//       },
//       transitionBuilder: (context, a1, a2, widget) {
//         var size = MediaQuery.of(context).size;
//         return Transform.scale(
//           scale: a1.value,
//           child: Opacity(
//             opacity: a1.value,
//             child: Center(
//               child: Container(
//                 padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
//                 width: size.width * .8,
//                 height: size.height * 0.9,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                   // color: Colors.white,
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     Text(
//                       'Select Mode',
//                       style: TextStyle(
//                         fontFamily: 'San-francisco',
//                         color: Colors.white,
//                         fontSize: 25,
//                         fontWeight: FontWeight.w500,
//                         decoration: TextDecoration.none,
//                       ),
//                     ),
//                     SizedBox(
//                       height: size.height * .02,
//                     ),
//                     _buildSelectModeContainer(
//                         size, 'assets/images/dineinmode.jpg', 'Dine In'),
//                     SizedBox(
//                       height: size.height * .02,
//                     ),
//                     _buildSelectModeContainer(
//                         size, 'assets/images/tablemode.jpg', 'Table'),
//                     SizedBox(
//                       height: size.height * .02,
//                     ),
//                     _buildSelectModeContainer(
//                         size, 'assets/images/takoutmode.jpg', 'Take Out'),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   });
// }

// ______________________ Model Unuse___________________________________

// _buildTableContainer(Size size, bool orientation) {
//   return Container(
//     height: size.height,
//     width: double.infinity,
//     child: Column(
//       children: <Widget>[
//         Container(
//           width: double.infinity,
//           height: 50,
//           decoration: BoxDecoration(color: Colors.white, boxShadow: [
//             BoxShadow(
//               offset: Offset(0, 4),
//               blurRadius: 10,
//               color: Colors.black12,
//             )
//           ]),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: _buildHeaderChoice(),
//           ),
//         ),
//         Expanded(
//           child: FutureBuilder(
//             future: menuData,
//             builder: (BuildContext context, AsyncSnapshot snapshot) {
//               if (!snapshot.hasData) {
//                 return Center(child: CircularProgressIndicator());
//               }
//               return Container(
//                 width: double.infinity,
//                 height: size.height,
//                 child: VerticalTabs(
//                   indicatorColor: Color(0xffb01105),
//                   tabsWidth:
//                       orientation ? size.width * .09 : size.width * .23,
//                   selectedTabBackgroundColor: null,
//                   contentScrollAxis: Axis.vertical,
//                   tabs: List.generate(
//                     snapshot.data.length,
//                     (index) {
//                       return Tab(
//                         child: _buildMainFloorTab(snapshot, index),
//                       );
//                     },
//                   ),
//                   contents: List.generate(
//                     snapshot.data.length,
//                     (index) {
//                       var tableList = snapshot.data[index].items;
//                       return Container(
//                         color: Color(0xfff5f5f5),
//                         child: Column(
//                           children: <Widget>[
//                             _buildTitleHeader(snapshot, index),
//                             Expanded(
//                               child: GridView.count(
//                                 shrinkWrap: true,
//                                 physics: ScrollPhysics(),
//                                 scrollDirection: Axis.vertical,
//                                 childAspectRatio: orientation
//                                     ? size.height / 750
//                                     : size.height / 1000,
//                                 crossAxisCount: size.width <= 800.0
//                                     ? 3
//                                     : size.width >= 1000.0 ? 5 : 4,
//                                 children: List<Widget>.generate(
//                                   tableList.length,
//                                   (index) {
//                                     return Stack(
//                                       children: <Widget>[
//                                         Container(
//                                           margin: EdgeInsets.only(
//                                             bottom: 15,
//                                             right: 10,
//                                             left: 10,
//                                           ),
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(5),
//                                             border: Border.all(
//                                               width: 1.3,
//                                               color: Color(0xff0f0808),
//                                             ),
//                                           ),
//                                           child: Material(
//                                             color: Colors.transparent,
//                                             child: InkWell(
//                                               splashColor: Colors.black12,
//                                               onTap: () {},
//                                               child: Column(
//                                                 children: <Widget>[
//                                                   _buildImageContainer(
//                                                     orientation,
//                                                     size,
//                                                     tableList,
//                                                     index,
//                                                   ),
//                                                   // _buildContainerData(
//                                                   //   orientation,
//                                                   //   size,
//                                                   //   tableList,
//                                                   //   index,
//                                                   // )
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               );
//             },
//           ),
//         )
//       ],
//     ),
//   );
// }

// _buildGridViewTable(bool orientation, Size size) {
//   return GridView.count(
//     shrinkWrap: true,
//     physics: ScrollPhysics(),
//     scrollDirection: Axis.vertical,
//     childAspectRatio: orientation ? size.height / 800 : size.height / 1100,
//     crossAxisCount: size.width <= 800.0 ? 3 : size.width >= 1000.0 ? 5 : 4,
//     children: List<Widget>.generate(
//       40,
//       (index) {
//         return TableCard(
//           index: index,
//         );
//       },
//     ),
//   );
// }

// _buildCupon() {
//   return Container(
//     width: 100.0,
//     height: 25.0,
//     margin: EdgeInsets.only(left: 10.0),
//     alignment: Alignment.center,
//     padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(25.0),
//       color: Colors.black87,
//     ),
//     child: Text(
//       "Use Cupon",
//       style: TextStyle(
//         color: Colors.white,
//         fontSize: 12,
//       ),
//     ),
//   );
// }

// _buildTotalAmountContainer(size, BuildContext context) {
//   return Container(
//     height: size.height * 0.08,
//     color: Color(0xfff0f0f0),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: <Widget>[
//         Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               'Quantity',
//               style: TextStyle(
//                 fontSize: 12.0,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black87,
//               ),
//             ),
//             SizedBox(height: 5),
//             Text(
//               'Total',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//                 fontSize: 15,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           width: 10,
//         ),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: <Widget>[
//             Text(
//               '20',
//               style: TextStyle(
//                 fontSize: 18.0,
//                 color: kPrimaryColor,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 5),
//             Text(
//               '\$538.4',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         )
//       ],
//     ),
//   );
// }
