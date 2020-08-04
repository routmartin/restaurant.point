import 'package:flutter/material.dart';
import 'package:pointrestaurant/screens/order/components/event_button.dart';
import 'package:pointrestaurant/screens/order/components/order_list.dart';
import 'package:pointrestaurant/screens/order/popDialog/paymentMethod.dart';

// void payDialog(context, size) {
//   var screeOrientation = MediaQuery.of(context).orientation;
//   showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//             backgroundColor: Colors.transparent,
//             child: Container(
//               height: screeOrientation == Orientation.landscape
//                   ? size.height * 0.8
//                   : size.height * 0.58,
//               width: screeOrientation == Orientation.landscape
//                   ? size.width * 0.4
//                   : double.infinity,
//               child: Stack(
//                 children: <Widget>[
//                   Container(
//                       margin: EdgeInsets.all(5.0),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                           color: Colors.white),
//                       child: Column(
//                         children: <Widget>[
//                           Container(
//                               height: size.height * 0.07,
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10.0),
//                                     color: Colors.blueGrey[50]),
//                                 alignment: Alignment.center,
//                                 child: Text(
//                                   "Your Order Summary(Dine In)",
//                                   style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               )),
//                           OrderList(size: size),
//                           Container(
//                             height: size.height * 0.08,
//                             child: Row(
//                               children: <Widget>[
//                                 Container(
//                                   width: 100.0,
//                                   height: 30.0,
//                                   margin: EdgeInsets.only(left: 10.0),
//                                   alignment: Alignment.center,
//                                   padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10.0),
//                                       color: Colors.black),
//                                   child: Text(
//                                     "Use Cupon",
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                 ),
//                                 Expanded(
//                                     child: Container(
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: <Widget>[
//                                       Expanded(
//                                         child: Container(
//                                             alignment: Alignment.centerRight,
//                                             child: Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               children: <Widget>[
//                                                 Text(
//                                                   'Quantity',
//                                                   style:
//                                                       TextStyle(fontSize: 10.0),
//                                                 ),
//                                                 // SizedBox(height: 5),
//                                                 Text('Total',
//                                                     style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         color: kPrimaryColor)),
//                                               ],
//                                             )),
//                                       ),
//                                       SizedBox(
//                                         width: 5,
//                                       ),
//                                       Expanded(
//                                         child: Container(
//                                             alignment: Alignment.centerRight,
//                                             margin:
//                                                 EdgeInsets.only(right: 15.0),
//                                             child: Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               children: <Widget>[
//                                                 Text('20',
//                                                     style: TextStyle(
//                                                         fontSize: 10.0)),
//                                                 // SizedBox(height: 5),
//                                                 Text(
//                                                   '\$538.4',
//                                                   style: TextStyle(
//                                                       color: kPrimaryColor),
//                                                 ),
//                                               ],
//                                             )),
//                                       )
//                                     ],
//                                   ),
//                                 ))
//                               ],
//                             ),
//                           ),
//                           Container(
//                             padding: EdgeInsets.all(10.0),
//                             height: size.height * 0.08,
//                             alignment: Alignment.center,
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: <Widget>[
//                                 Expanded(
//                                   child: Container(
//                                     alignment: Alignment.centerLeft,
//                                     child: Button(
//                                       buttonName: "Continue",
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 40.0,
//                                 ),
//                                 Expanded(
//                                   child: Container(
//                                     alignment: Alignment.centerRight,
//                                     child: Button(
//                                       buttonName: "Pay",
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           )
//                         ],
//                       )),
//                   _buildCancelButton(context)
//                 ],
//               ),
//             ));
//       });
// }

// _buildCancelButton(BuildContext context) {
//   return Positioned(
//     top: 0,
//     right: 0,
//     child: Material(
//       color: Color(0xffcc2d2d),
//       borderRadius: BorderRadius.circular(15),
//       child: InkWell(
//         onTap: () {
//           Navigator.pop(context);
//         },
//         splashColor: Colors.white38,
//         child: Container(
//           width: 25,
//           height: 25,
//           child: Center(
//             child: Text(
//               'x',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontFamily: "San-francisco",
//                 fontWeight: FontWeight.w200,
//               ),
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }
void payDialog(context, size) {
  Color bnkColor = Colors.white;
  var screeOrientation = MediaQuery.of(context).orientation;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: bnkColor,
                ),
                height: screeOrientation == Orientation.landscape
                    ? size.height * 0.8
                    : size.height * 0.58,
                width: screeOrientation == Orientation.landscape
                    ? size.width * 0.4
                    : double.infinity,
                child: Column(
                  children: <Widget>[
                    _buildHeaderTitle(size),
                    OrderList(size: size),
                    _buildTotalAmountContainer(size, context),
                    _buildButtonContainer(size, context)
                  ],
                ),
              ),
              _buildCancelButton(context)
            ],
          ),
        ),
      );
    },
  );
}

_buildCancelButton(BuildContext context) {
  return Positioned(
    top: 0,
    right: 0,
    child: Material(
      color: Color(0xffcc2d2d),
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        splashColor: Colors.white38,
        child: Container(
          width: 25,
          height: 25,
          child: Center(
            child: Text(
              'x',
              style: TextStyle(
                color: Colors.white,
                fontFamily: "San-francisco",
                fontWeight: FontWeight.w200,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

_buildHeaderTitle(size) {
  return Container(
    height: size.height * 0.1,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    alignment: Alignment.center,
    child: Text(
      "Your Order Summary(Dine In)",
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

_buildButtonContainer(size, BuildContext context) {
  var screeOrientation = MediaQuery.of(context).orientation;
  return Container(
    height: screeOrientation == Orientation.landscape
        ? size.height * 0.1
        : size.height * 0.08,
    margin: EdgeInsets.symmetric(horizontal: 10),
    child: FittedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Button(
            buttonName: "Continue",
          ),
          SizedBox(
            width: screeOrientation == Orientation.landscape ? 100 : 20,
          ),
          Button(
            buttonName: "Pay",
          )
        ],
      ),
    ),
  );
}

_buildTotalAmountContainer(size, BuildContext context) {
  return Container(
    height: size.height * 0.08,
    color: Color(0xfff0f0f0),
    child: Row(
      children: <Widget>[
        InkWell(
          onTap: () {
            paymentMethod(context, size);
          },
          child: _buildCupon(),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Quantity',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Total',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    '20',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '\$538.4',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    ),
  );
}

_buildCupon() {
  return Container(
    width: 100.0,
    height: 25.0,
    margin: EdgeInsets.only(left: 10.0),
    alignment: Alignment.center,
    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.black87,
    ),
    child: Text(
      "Use Cupon",
      style: TextStyle(
        color: Colors.white,
        fontSize: 12,
      ),
    ),
  );
}
