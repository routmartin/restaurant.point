import 'package:flutter/material.dart';
import 'package:pointrestaurant/utilities/path.dart';
import 'package:pointrestaurant/utilities/style.main.dart';

class VerticalMenuContainer extends StatelessWidget {
  final AsyncSnapshot snapshot;
  final int index;
  VerticalMenuContainer({Key key, this.snapshot, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: size.width <= 360.0
                ? size.height * .13
                : size.width <= 400.0
                    ? size.height * .14
                    : size.width >= 1000.0
                        ? size.height * .18
                        : size.height * .14,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(9),
                boxShadow: [
                  BoxShadow(color: Colors.grey[600], blurRadius: 10)
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: size.width <= 360.0
                      ? size.height * .11
                      : size.width <= 400.0
                          ? size.height * .09
                          : size.width >= 1000.0
                              ? size.height * .12
                              : size.height * .09,
                  child: Image.network(
                    serverIP + snapshot.data[index].photo,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: Text(
                      snapshot.data[index].typeName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 0.7,
                        fontFamily: "San-francisco",
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        snapshot.data[index].hasOrder.toString() != '0'
            ? Positioned(
                top: 5,
                right: 5,
                child: Container(
                  alignment: Alignment.center,
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    snapshot.data[index].hasOrder,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "San-francisco",
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}
