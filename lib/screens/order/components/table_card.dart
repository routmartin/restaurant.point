import 'package:flutter/material.dart';
import 'package:pointrestaurant/utilities/path.dart';
import 'package:pointrestaurant/widget/botton_middle_button.dart';


class TableCard extends StatelessWidget {
  const TableCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              bottom: 15,
              right: 10,
            ),
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
                  child: FadeInImage.assetNetwork(
                    placeholder: preLoading,
                    image:
                        'https://thumbs.dreamstime.com/b/modern-restaurant-table-tablecloth-coffe-mugs-flowers-two-chairs-bright-colored-cartoon-vector-modern-restaurant-table-115024181.jpg',
                    height: 75,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            'VIP001',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xff121010),
                              fontFamily: "San-francisco",
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            '8:00 AM',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xff121010),
                              fontFamily: "San-francisco",
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        '\$ 5.00',
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(
                            0xff121010,
                          ),
                          fontFamily: "San-francisco",
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            left: MediaQuery.of(context).size.width * .05,
            child: BottomMiddleButton(
              width: 60,
              sign: Text(
                'Bill',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
