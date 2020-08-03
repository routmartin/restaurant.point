import 'package:flutter/material.dart';
import 'package:pointrestaurant/utilities/path.dart';
import 'package:pointrestaurant/widget/botton_middle_button.dart';

class TableCard extends StatelessWidget {
  final int index;
  const TableCard({
    Key key,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var orientation =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.black12,
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
                    margin: EdgeInsets.only(
                      top: orientation ? size.height * .02 : size.height * .01,
                    ),
                    child: FadeInImage.assetNetwork(
                      placeholder: preLoading,
                      image:
                          'https://thumbs.dreamstime.com/b/modern-restaurant-table-tablecloth-coffe-mugs-flowers-two-chairs-bright-colored-cartoon-vector-modern-restaurant-table-115024181.jpg',
                      height:
                          orientation ? size.height * .12 : size.height * .05,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: orientation
                              ? size.height * .02
                              : size.height * .01,
                        ),
                        FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                'VIP' + index.toString(),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xff121010),
                                  fontFamily: "San-francisco",
                                  fontWeight: FontWeight.bold,
                                  fontSize: orientation ? 17 : 11,
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                '8:00 AM',
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xff121010),
                                  fontFamily: "San-francisco",
                                  fontWeight: FontWeight.bold,
                                  fontSize: orientation ? 13 : 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: orientation
                              ? size.height * .01
                              : size.height * .007,
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
                            fontSize: orientation ? 18 : 13,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: orientation ? 7 : 8,
              left: orientation ? size.width * .056 : size.width * .035,
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
      ),
    );
  }
}
