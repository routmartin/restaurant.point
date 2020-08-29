import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pointrestaurant/models/floor.dart';
import 'package:pointrestaurant/models/ordersummery.dart';

import 'package:pointrestaurant/services/table_model/floor_service.dart';
import 'package:pointrestaurant/services/table_model/order_summery_sevice.dart';

import 'package:pointrestaurant/utilities/path.dart';
import 'package:pointrestaurant/utilities/style.main.dart';
import 'package:pointrestaurant/widget/center_loading_indecator.dart';

import 'package:vertical_tabs/vertical_tabs.dart';

import 'components/event_button.dart';
import 'components/header_icon_type.dart';

import 'components/order_cal_icon.dart';
import 'menu_screen.dart';

class TableModeScreen extends StatefulWidget {
  @override
  _TableModeScreenState createState() => _TableModeScreenState();
}

class _TableModeScreenState extends State<TableModeScreen> {
  Future<List<Floor>> floorData;
  Future<List<Ordersummery>> orderSummery;
//________________Open Switch Container Layout________________________

  int _pageState = 0;
  double _loginWidth = 0;
  double _loginHeight = 0;

  double _loginYOffset = 0;
  double _loginXOffset = 0;
  double _registerYOffset = 0;
  double _registerHeight = 0;

  double windowWidth = 0;
  double windowHeight = 0;

  int totalItems = 0;
  double totalAmount = 0;
//________________Close Switch Container Layout________________________
  @override
  void initState() {
    super.initState();
    floorData = fetchDataFloors();
  }

  int saleMasterId;
  int tableId;
  String tableName;

  showSumeryModal({tableList}) {
    tableName = tableList.tableName;
    tableId = tableList.tableId;
    saleMasterId = tableList.saleMasterId;
    orderSummery = fetchOrderSummery(
      table_id: tableList.tableId,
      sale_master_id: tableList.saleMasterId,
    );
    setState(() {
      if (_pageState != 0) {
        _pageState = 0;
      } else {
        _pageState = 1;
      }
    });
  }

  pushToMenuScree({sale_master_id, table_id, table_name}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MenuScreen(
          saleMasterId: sale_master_id ?? saleMasterId,
          tableId: table_id ?? tableId,
          tableName: table_name ?? tableName,
        ),
      ),
    ).then((value) => value
        ? {
            setState(() {
              floorData = fetchDataFloors();
              _pageState = 0;
            }),
          }
        : null);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var orientation =
        MediaQuery.of(context).orientation == Orientation.landscape;

    windowHeight = size.height;
    windowWidth = size.width;

    switch (_pageState) {
      case 0:
        _loginWidth = windowWidth;
        _loginYOffset = windowHeight;
        _loginXOffset = 0;
        _registerYOffset = windowHeight;
        break;
      case 1:
        _loginWidth = windowWidth;
        _loginYOffset = orientation ? size.height * .08 : size.height * .03;
        _loginXOffset = 0;
        _registerYOffset = windowHeight;
        break;
      case 2:
        _loginWidth = windowWidth - 40;
        _loginYOffset = 180;
        _loginXOffset = 0;
        _registerYOffset = 250;
        _registerHeight = windowHeight - 100;
        break;
    }

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
                          child: FittedBox(
                            child: _buildHeaderChoice(),
                          ),
                        ),
                      ),
                      Expanded(
                        child: FutureBuilder(
                          future: floorData,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child: CenterLoadingIndicator());
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
                                          _buildVerticleTitleHeader(
                                              snapshot, index),
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
                                                  int hasItems = int.parse(
                                                      tableList[index]
                                                          .hasItemsOrder);
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
                                                              0xff0f0808,
                                                            ),
                                                          ),
                                                        ),
                                                        child: Material(
                                                          color: Colors
                                                              .transparent,
                                                          child: InkWell(
                                                            splashColor:
                                                                Colors.black12,
                                                            onTap: tableList[
                                                                                index]
                                                                            .saleMasterId !=
                                                                        0 &&
                                                                    hasItems >=
                                                                        1
                                                                ? () =>
                                                                    showSumeryModal(
                                                                      tableList:
                                                                          tableList[
                                                                              index],
                                                                    )
                                                                : () => {
                                                                      pushToMenuScree(
                                                                        sale_master_id:
                                                                            0,
                                                                        table_id:
                                                                            tableList[index].tableId,
                                                                        table_name:
                                                                            tableList[index].tableName,
                                                                      )
                                                                    },
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
          AnimatedContainer(
            alignment: Alignment.center,
            width: orientation ? size.width * .4 : null,
            height: orientation ? size.height * .8 : null,
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(milliseconds: 1000),
            transform:
                Matrix4.translationValues(_loginXOffset, _loginYOffset, 1),
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  offset: Offset(1, 5),
                  color: Colors.black38.withOpacity(.2),
                  blurRadius: 20,
                  spreadRadius: 10,
                ),
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  height: orientation ? size.height * 0.8 : double.infinity,
                  width: orientation ? size.width * 0.4 : double.infinity,
                  child: Column(
                    children: <Widget>[
                      _buildHeaderTitle(size),
                      Container(
                        height: orientation
                            ? size.height * 0.52
                            : size.height * 0.55,
                        color: Color(0xfff0f0f0),
                        child: FutureBuilder(
                          future: orderSummery,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return CenterLoadingIndicator();
                            }
                            totalItems = snapshot.data.length;
                            return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                var data = snapshot.data[index];

                                return Container(
                                  alignment: Alignment.centerLeft,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 0.2,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Expanded(
                                              flex: 3,
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      data.name,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'San-francisco',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      "\$ ${data.unitPrice}",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'San-francisco',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  "\$ ${data.amount}",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          CaculateIcon(
                                            qty: data.qty,
                                          ),
                                          _buildSpecilRequest(context)
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Container(
                        height: size.height * 0.08,
                        color: Colors.grey[300],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Order Items',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Total',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  totalItems.toString(),
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  '\$ ${totalAmount}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: orientation
                            ? size.height * 0.1
                            : size.height * 0.09,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Button(
                                  buttonName: "Continue",
                                  press: () {
                                    pushToMenuScree();
                                  },
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Button(
                                  buttonName: "Print Bill",
                                  press: () {},
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Button(
                                  buttonName: "Payment",
                                  press: () {},
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _pageState == 1 ? _buildCancelButton(context) : Container()
              ],
            ),
          ),
          AnimatedContainer(
            width: orientation ? size.width * .45 : size.width,
            height: _registerHeight,
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(milliseconds: 1000),
            transform: Matrix4.translationValues(0, _registerYOffset, 1),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 3),
                    color: Colors.black12.withOpacity(0.3),
                    blurRadius: 20,
                  ),
                ]),
            child: Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: size.height * .35,
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "Special Request",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  "Spicy classic",
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          children: <Widget>[
                                            Expanded(
                                                flex: 2, child: Container()),
                                            Expanded(
                                                flex: 1,
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    color: Colors.grey[300],
                                                  ),
                                                  child: Text(
                                                    "choose 1 item",
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ))
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                              Expanded(
                                flex: 6,
                                child: Container(
                                  margin: EdgeInsets.only(top: 10.0),
                                  child: ListView.builder(
                                    itemCount: 4,
                                    itemBuilder: (context, index) {
                                      return Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {},
                                          child: Container(
                                            padding: EdgeInsets.all(10.0),
                                            margin: EdgeInsets.only(
                                                top: 5.0, left: 5, right: 5.0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 1,
                                                    blurRadius: 7,
                                                    offset: Offset(0, 1),
                                                  )
                                                ]),
                                            child: Row(
                                              children: <Widget>[
                                                Icon(
                                                  FontAwesomeIcons.check,
                                                  size: 15,
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Text("$index Egg")
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.09),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Button(
                                buttonName: "Reset All",
                              ),
                              SizedBox(
                                width: orientation ? 100 : 20,
                              ),
                              Button(
                                buttonName: "Ok +9.99",
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  _pageState == 2 ? _buildCancelButton(context) : Container()
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  _buildContainerData(bool orientation, Size size, tableList, int index) {
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
                  height: orientation ? size.height * .015 : 4,
                )
              : SizedBox(
                  height: orientation ? size.height * .03 : 12,
                ),
          Column(
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
                      height: orientation ? size.height * .015 : 4,
                    )
                  : SizedBox(
                      height: orientation ? size.height * .014 : 3,
                    ),
              tableList[index].tableStatus != 'free'
                  ? Container(
                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          tableList[index].checkinDuration,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "San-francisco",
                            fontWeight: FontWeight.bold,
                            fontSize: orientation ? 15 : 11,
                          ),
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
        ],
      ),
    );
  }

  _buildImageContainer(bool orientation, Size size, tableList, int index) {
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

  _buildMainFloorTab(AsyncSnapshot snapshot, int index) {
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

  _buildVerticleTitleHeader(AsyncSnapshot snapshot, int index) {
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
    return Row(
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
    );
  }

  // ______________________ Intenal Widget __________________________
  // special Request___________________________________

  _buildSpecilRequest(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.2,
          color: Colors.grey[400],
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              _pageState = 2;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Text(
              "SPECIAL REQUEST",
              style: TextStyle(
                fontSize: 8,
                fontFamily: 'San-francisco',
                color: kPrimaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // orderSummery inner_width________________________

  _buildCancelButton(BuildContext context) {
    return Positioned(
      top: 7,
      right: 5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Material(
          color: Color(0xffcc2d2d),
          borderRadius: BorderRadius.circular(15),
          child: InkWell(
            onTap: () {
              setState(() {
                if (_pageState == 2) {
                  _pageState = 1;
                } else if (_pageState == 1) {
                  _pageState = 0;
                }
              });
            },
            splashColor: Colors.white38,
            child: Container(
              width: 25,
              height: 25,
              child: Center(
                child: Text(
                  'x',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "San-francisco",
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildHeaderTitle(size) {
    return Container(
      height: size.height * 0.08,
      decoration: BoxDecoration(
        color: bkColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        "Your Order Summary(Dine In)",
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
