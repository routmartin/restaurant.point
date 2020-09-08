import 'package:flutter/material.dart';
import 'package:pointrestaurant/widget/botton_middle_button.dart';

class RestaurantCard extends StatelessWidget {
  final String imgPath;
  final String title;
  final Function press;
  RestaurantCard({this.title, this.imgPath, this.press});

  @override
  Widget build(BuildContext context) {
    var ctx = MediaQuery.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        children: <Widget>[
          Container(
            width: ctx.orientation == Orientation.landscape
                ? ctx.size.width * 0.18
                : ctx.size.width * .35,
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 1.5),
                  blurRadius: 7,
                )
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: press,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                      child: Container(
                        width: double.infinity,
                        child: Image.asset(
                          imgPath,
                          fit: BoxFit.cover,
                          height: ctx.orientation == Orientation.landscape
                              ? ctx.size.height * .16
                              : ctx.size.height * .115,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).orientation ==
                              Orientation.landscape
                          ? ctx.size.height * .02
                          : ctx.size.height * .01,
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).orientation ==
                                    Orientation.landscape
                                ? 17
                                : 14,
                            fontFamily: 'San-francisco',
                            fontWeight: FontWeight.w800,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Positioned(
          //   bottom: 0,
          //   left: ctx.orientation == Orientation.landscape
          //       ? ctx.size.width * .09
          //       : ctx.size.width * .175,
          //   child: BottomMiddleButton(
          //     sign: Text(
          //       '+',
          //       style: TextStyle(
          //         color: Colors.white,
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
