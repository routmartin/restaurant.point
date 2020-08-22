import 'package:flutter/material.dart';
import 'package:pointrestaurant/models/floor.dart';

import 'package:pointrestaurant/services/table_mode_floor_service.dart';
import 'package:pointrestaurant/services/table_mode_menu_service.dart';
import 'package:pointrestaurant/utilities/path.dart';
import 'package:pointrestaurant/utilities/style.main.dart';

import 'package:vertical_tabs/vertical_tabs.dart';

import 'components/header_icon_type.dart';

class TableModeScreen extends StatefulWidget {
  @override
  _TableModeScreenState createState() => _TableModeScreenState();
}

class _TableModeScreenState extends State<TableModeScreen> {
  Future<List<Floor>> floorData;

  @override
  void initState() {
    super.initState();
    floorData = fetchDataFloors();
    fetchMenuSevice();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var orientation =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Stack(
        children: <Widget>[
          Container(
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
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
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
                      Expanded(
                        child: FutureBuilder(
                          future: floorData,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
                            }
                            return Container(
                              width: double.infinity,
                              height: size.height,
                              child: VerticalTabs(
                                indicatorColor: Color(0xffb01105),
                                tabsWidth: orientation
                                    ? size.width * .09
                                    : size.width * .23,
                                selectedTabBackgroundColor: null,
                                contentScrollAxis: Axis.vertical,
                                tabs: List.generate(
                                  snapshot.data.length,
                                  (index) {
                                    return Tab(
                                      child:
                                          _buildMainFloorTab(snapshot, index),
                                    );
                                  },
                                ),
                                contents: List.generate(
                                  snapshot.data.length,
                                  (index) {
                                    var tableList = snapshot.data[index].tables;
                                    return Container(
                                      color: Color(0xfff5f5f5),
                                      child: Column(
                                        children: <Widget>[
                                          _buildTitleHeader(snapshot, index),
                                          Expanded(
                                            child: GridView.count(
                                              shrinkWrap: true,
                                              physics: ScrollPhysics(),
                                              scrollDirection: Axis.vertical,
                                              childAspectRatio: orientation
                                                  ? size.height / 750
                                                  : size.height / 1000,
                                              crossAxisCount:
                                                  size.width <= 800.0
                                                      ? 3
                                                      : size.width >= 1000.0
                                                          ? 5
                                                          : 4,
                                              children: List<Widget>.generate(
                                                tableList.length,
                                                (index) {
                                                  return Stack(
                                                    children: <Widget>[
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                          bottom: 15,
                                                          right: 10,
                                                          left: 10,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          border: Border.all(
                                                            width: 1.3,
                                                            color: Color(
                                                                0xff0f0808),
                                                          ),
                                                        ),
                                                        child: Material(
                                                          color: Colors
                                                              .transparent,
                                                          child: InkWell(
                                                            splashColor:
                                                                Colors.black12,
                                                            onTap: () {},
                                                            child: Column(
                                                              children: <
                                                                  Widget>[
                                                                _buildImageContainer(
                                                                  orientation,
                                                                  size,
                                                                  tableList,
                                                                  index,
                                                                ),
                                                                _buildContainerData(
                                                                  orientation,
                                                                  size,
                                                                  tableList,
                                                                  index,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }

  Padding _buildContainerData(
      bool orientation, Size size, tableList, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          tableList[index].tableStatus != 'free'
              ? SizedBox(
                  height: orientation ? size.height * .015 : 3,
                )
              : SizedBox(
                  height: orientation ? size.height * .03 : 15,
                ),
          FittedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  tableList[index].tableName,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff121010),
                    fontFamily: "San-francisco",
                    fontWeight: FontWeight.bold,
                    fontSize: orientation ? 18 : 11,
                  ),
                ),
                tableList[index].tableStatus != 'free'
                    ? SizedBox(
                        height: orientation ? size.height * .015 : 3,
                      )
                    : SizedBox(
                        height: orientation ? size.height * .014 : 3,
                      ),
                tableList[index].tableStatus != 'free'
                    ? _buildTimePriiceContianer(orientation)
                    : Container()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buildTimePriiceContianer(bool orientation) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 6),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: <Widget>[
          Text(
            '\$ 5.00',
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontFamily: "San-francisco",
              fontWeight: FontWeight.bold,
              fontSize: orientation ? 15 : 11,
            ),
          ),
          VerticalDivider(
            width: 10,
          ),
          Text(
            '00:30',
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontFamily: "San-francisco",
              fontWeight: FontWeight.bold,
              fontSize: orientation ? 15 : 11,
            ),
          ),
        ],
      ),
    );
  }

  Container _buildImageContainer(
      bool orientation, Size size, tableList, int index) {
    return Container(
      margin: EdgeInsets.only(
        top: orientation ? size.height * .02 : size.height * .01,
      ),
      child: FadeInImage.assetNetwork(
        placeholder: preLoading,
        image: serverIP + tableList[index].tableImage,
        height: orientation ? size.height * .12 : size.height * .05,
        width: double.infinity,
        fit: BoxFit.fitWidth,
      ),
    );
  }

  Container _buildMainFloorTab(AsyncSnapshot snapshot, int index) {
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
                bottom: BorderSide(
                  color: Colors.black,
                  width: 1.5,
                ),
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              height: 75,
              child: Image.asset(
                floor,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            snapshot.data[index].floorName,
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

  _buildTitleHeader(AsyncSnapshot snapshot, int index) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Text(
        snapshot.data[index].floorName,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          fontFamily: 'San-francisco',
        ),
      ),
    );
  }

  // orderSummery inner_width________________________

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
