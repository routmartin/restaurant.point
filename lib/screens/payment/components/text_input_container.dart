import 'package:flutter/material.dart';

class TextInputContainer extends StatelessWidget {
  final String title;
  const TextInputContainer({
    Key key,
    @required this.textfieldWidth,
    this.title: 'KH',
  }) : super(key: key);

  final double textfieldWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 4),
            child: Text(
              title,
              style: TextStyle(
                fontFamily: "San-francisco",
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Container(
            width: textfieldWidth,
            height: 50.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: title,
                  contentPadding: EdgeInsets.all(15.0),
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
