import 'package:flutter/material.dart';

class FloorContainer extends StatelessWidget {
  final int index;
  const FloorContainer({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
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
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black, width: 1.5),
                ),
              ),
              child: Container(
                alignment: Alignment.center,
                height: 75,
                child: Text(
                  'Floor' + index.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              )),
          SizedBox(
            height: 3,
          ),
          Text(
            'Point Restaurant',
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
