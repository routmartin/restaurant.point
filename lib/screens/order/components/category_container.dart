import 'package:flutter/material.dart';
import 'package:pointrestaurant/utilities/path.dart';


class CategoryContainer extends StatelessWidget {
  const CategoryContainer({
    Key key,
  }) : super(key: key);

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
            child: FadeInImage.assetNetwork(
              placeholder: preLoading,
              image:
                  'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?ixlib=rb-1.2.1&w=1000&q=80',
              height: 75,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
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
                fontSize: 11),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
