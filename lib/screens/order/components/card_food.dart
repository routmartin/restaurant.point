import 'package:flutter/material.dart';
import 'package:pointrestaurant/utilities/path.dart';
import 'package:pointrestaurant/widget/botton_middle_button.dart';



class CardFood extends StatelessWidget {
  const CardFood({
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
                          'https://www.wbcsd.org/var/site/storage/images/media/images/fresh_pa/80809-2-eng-GB/FRESH_PA_i1140.jpg',
                      height: 85,
                      width: double.infinity,
                      fit: BoxFit.cover,
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
                        Text(
                          'Point Restaurant',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff121010),
                            fontFamily: "San-francisco",
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
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
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 3,
              left: 40,
              child: BottomMiddleButton(
                sign: Text(
                  '+',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
