import 'package:flutter/material.dart';
import 'package:vertical_tabs/vertical_tabs.dart';

import 'components/Iconbutton.dart';
import 'components/bottom_label_checkout.dart';
import 'components/category_container.dart';

import 'components/order_label_check_out.dart';

import 'components/order_tab_body_list.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 10,
                      color: Colors.black12,
                    )
                  ]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconbuttonType(
                          title: 'Dine In',
                          isActive: true,
                        ),
                        IconbuttonType(
                          title: 'Table',
                          isActive: false,
                        ),
                        IconbuttonType(
                          title: 'Take Out',
                          isActive: false,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: VerticalTabs(
                      indicatorColor: Color(0xffb01105),
                      tabsWidth: 90,
                      selectedTabBackgroundColor: null,
                      contentScrollAxis: Axis.vertical,
                      tabs: List.generate(5, (index) {
                        return Tab(
                          child: CategoryContainer(),
                        );
                      }),
                      contents: List.generate(
                        5,
                        (index) {
                          return OrderTabBodyList(
                            tabTitle: 'Spicy Classic',
                          );
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          BottomLabelCheckOut(),
          OrderLabelCheckOut()
        ],
      )),
    );
  }
}
