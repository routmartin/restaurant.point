import 'package:flutter/material.dart';
import 'package:pointrestaurant/utilities/style.main.dart';
import 'order_item.dart';

class BottomLabelCheckOut extends StatelessWidget {
  const BottomLabelCheckOut({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: MediaQuery.of(context).size.width,
      left: 1,
      bottom: 0,
      child: Container(
        height: 70,
        color: Color(0xffebebeb),
        child: Row(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * .2,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FittedBox(
                    child: Text(
                      'Selected',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w600,
                        color: Color(0xff787878),
                      ),
                    ),
                  ),
                  FittedBox(
                    child: Text(
                      'Items',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w600,
                        color: Color(0xff787878),
                      ),
                    ),
                  ),
                  FittedBox(
                    child: Text(
                      '11',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .5,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 1),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: false,
                physics: ScrollPhysics(),
                itemCount: 10,
                itemBuilder: (ctx, index) {
                  return OrderItems();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
