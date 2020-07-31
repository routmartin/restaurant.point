import 'package:flutter/material.dart';

import 'order_item.dart';
import 'selected_item_container.dart';

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
            SelectedItemContainer(),
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
            )
          ],
        ),
      ),
    );
  }
}
