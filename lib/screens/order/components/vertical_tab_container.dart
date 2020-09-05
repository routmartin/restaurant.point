import 'package:flutter/material.dart';
import 'package:pointrestaurant/utilities/path.dart';

class VerticalTabContainer extends StatelessWidget {
  final AsyncSnapshot snapshot;
  final int index;
  VerticalTabContainer({Key key, this.snapshot, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          width: 1.3,
          color: Color(0xff0f0808),
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: 75,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 1.5,
                ),
              ),
            ),
            child: Image.network(
              serverIP + snapshot.data[index].photo,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            snapshot.data[index].typeName,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff121010),
              fontFamily: "San-francisco",
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
