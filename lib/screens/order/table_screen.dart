import 'package:flutter/material.dart';
import 'package:vertical_tabs/vertical_tabs.dart';
import 'components/header_icon_type.dart';
import 'components/bottom_label_checkout.dart';
import 'components/floor_container.dart';
import 'components/order_label_check_out.dart';
import 'components/table_card.dart';

class TableScreen extends StatefulWidget {
  @override
  _TableScreenState createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var orientation =
        MediaQuery.of(context).orientation == Orientation.landscape;
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
                    child: _buildHeaderChoice(),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: size.height,
                    child: VerticalTabs(
                      indicatorColor: Color(0xffb01105),
                      tabsWidth:
                          orientation ? size.width * .09 : size.width * .23,
                      selectedTabBackgroundColor: null,
                      contentScrollAxis: Axis.vertical,
                      tabs: List.generate(
                        5,
                        (index) {
                          return Tab(
                            child: FloorContainer(
                              index: index + 1,
                            ),
                          );
                        },
                      ),
                      contents: List.generate(
                        5,
                        (index) {
                          return Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                child: Text(
                                  'Floor ' + index.toString(),
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'San-francisco',
                                  ),
                                ),
                              ),
                              Expanded(
                                child: _buildGridViewTable(orientation, size),
                              ),
                            ],
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

  _buildGridViewTable(bool orientation, Size size) {
    return GridView.count(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      scrollDirection: Axis.vertical,
      childAspectRatio: orientation ? size.height / 800 : size.height / 1100,
      crossAxisCount: size.width <= 800.0 ? 3 : size.width >= 1000.0 ? 5 : 4,
      children: List<Widget>.generate(
        40,
        (index) {
          return TableCard(
            index: index,
          );
        },
      ),
    );
  }

  _buildHeaderChoice() {
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }
}
