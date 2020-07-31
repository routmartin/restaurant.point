import 'package:flutter/material.dart';
import 'package:pointrestaurant/screens/order/components/table_tab_body_list.dart';

import 'package:vertical_tabs/vertical_tabs.dart';

import 'components/Iconbutton.dart';

import 'components/bottom_label_checkout.dart';
import 'components/floor_container.dart';

import 'components/order_label_check_out.dart';

class TableScreen extends StatefulWidget {
  @override
  _TableScreenState createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: <Widget>[
          Container(
            height: size.height,
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
                          isActive: false,
                        ),
                        IconbuttonType(
                          title: 'Table',
                          isActive: true,
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
                          child: FloorContainer(
                            index: index + 1,
                          ),
                        );
                      }),
                      contents: List.generate(
                        5,
                        (index) {
                          return TableTabBodyList(
                            tabTitle: 'Floor Number' + (index + 1).toString(),
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
