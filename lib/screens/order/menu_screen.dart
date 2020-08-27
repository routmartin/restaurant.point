import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:pointrestaurant/models/menu.dart';
import 'package:pointrestaurant/models/note.dart';
import 'package:pointrestaurant/models/ordersummery.dart';
import 'package:pointrestaurant/services/list_note.dart';
import 'package:pointrestaurant/services/table_model/delete.dart';
import 'package:pointrestaurant/services/table_model/menu_service.dart';
import 'package:pointrestaurant/services/table_model/order_items.dart';
import 'package:pointrestaurant/services/table_model/order_summery_sevice.dart';

import 'package:pointrestaurant/utilities/path.dart';
import 'package:pointrestaurant/utilities/style.main.dart';
import 'package:pointrestaurant/widget/center_loading_indecator.dart';
import 'package:vertical_tabs/vertical_tabs.dart';

import 'components/event_button.dart';
import 'components/bottom_label_checkout.dart';

import 'components/order_cal_icon.dart';

class MenuScreen extends StatefulWidget {
  final saleMasterId;
  final tableId;
  final String tableName;
  const MenuScreen({
    Key key,
    this.saleMasterId,
    this.tableId,
    this.tableName,
  }) : super(key: key);
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  Future<List<Menu>> menuData;
  Future<List<Ordersummery>> orderSummery;
  Future<List<Note>> noteList;
  List<bool> checked = [true, true, false, false, true];

  @override
  void initState() {
    super.initState();
    menuData = fetchMenuSevice(saleMasterId: widget.saleMasterId);
  }

//________________Open Switch Container Layout________________________

  int _pageState = 0;
  double orderSummeryWidth = 0;
  double orderSummeryHeight = 0;

  double orderSummeryYOffset = 0;
  double orderSummeryXOffset = 0;

  double showNoteYOffset = 0;
  double showNoteHeight = 0;

  double windowWidth = 0;
  double windowHeight = 0;

  int totalItems = 0;
  double totalAmount = 0;
//________________Close Switch Container Layout________________________

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var orientation =
        MediaQuery.of(context).orientation == Orientation.landscape;
    windowHeight = size.height;
    windowWidth = size.width;

    switch (_pageState) {
      case 0:
        orderSummeryWidth = windowWidth;
        orderSummeryYOffset = windowHeight;
        orderSummeryXOffset = 0;
        showNoteYOffset = windowHeight;
        break;
      case 1:
        orderSummeryWidth = windowWidth;
        orderSummeryYOffset =
            orientation ? size.height * .08 : size.height * .12;
        orderSummeryXOffset = 0;
        showNoteYOffset = windowHeight;
        break;
      case 2:
        orderSummeryWidth = windowWidth - 40;
        orderSummeryYOffset = 120;
        orderSummeryXOffset = 0;

        showNoteYOffset = 180;
        showNoteHeight = windowHeight;
        break;
    }

    _requestNoItmesModel() {
      return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.9),
        transitionDuration: Duration(milliseconds: 100),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return null;
        },
        transitionBuilder: (context, a1, a2, widget) {
          var size = MediaQuery.of(context).size;
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                  width: size.width * .5,
                  height: size.height * .3,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Container(
                      child: Text('No Items Orders',
                          style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'San-francisco',
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.none,
                          )),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
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
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 4),
                                blurRadius: 10,
                                color: Colors.black12,
                              )
                            ],
                          ),
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  size: 20,
                                ),
                                onPressed: () => Navigator.pop(context, true),
                              ),
                              Expanded(
                                  child: Center(
                                child: Text(
                                  widget.tableName,
                                  style: TextStyle(
                                    fontFamily: 'San-francisco',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ))
                            ],
                          )),
                      Expanded(
                        child: FutureBuilder(
                          future: menuData,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return CenterLoadingIndicator();
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
                                    var tableList = snapshot.data[index].items;
                                    return Container(
                                      color: Color(0xfff5f5f5),
                                      child: Column(
                                        children: <Widget>[
                                          _buildTitleHeader(snapshot, index),
                                          Expanded(
                                            child: GridView.count(
                                              mainAxisSpacing: 5,
                                              shrinkWrap: true,
                                              physics: ScrollPhysics(),
                                              scrollDirection: Axis.vertical,
                                              childAspectRatio: orientation
                                                  ? size.height / 750
                                                  : size.height / 900,
                                              crossAxisCount:
                                                  size.width <= 800.0
                                                      ? 2
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
                                                            onTap: () {
                                                              addOrderItems(
                                                                itemDetailId:
                                                                    tableList[
                                                                            index]
                                                                        .itemDetailId,
                                                                saleMasterId: widget
                                                                    .saleMasterId,
                                                                tableId: widget
                                                                    .tableId,
                                                                saleDetailId:
                                                                    tableList[
                                                                            index]
                                                                        .saleDetailId,
                                                              );
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
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      tableList[index].qty !=
                                                              '0'
                                                          ? Positioned(
                                                              bottom: 5,
                                                              left: orientation
                                                                  ? size.width *
                                                                      0.055
                                                                  : size.width *
                                                                      0.1,
                                                              child:
                                                                  CaculateIcon(
                                                                qty: tableList[
                                                                        index]
                                                                    .qty,
                                                              ),
                                                            )
                                                          : Container()
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
                BottomLabelCheckOut(),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                    width: size.width * .28,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Material(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(4),
                      child: InkWell(
                        onTap: widget.saleMasterId != 0
                            ? () {
                                orderSummery = fetchOrderSummery(
                                  table_id: widget.tableId,
                                  sale_master_id: widget.saleMasterId,
                                );
                                noteList = fetchListNote();
                                setState(() {
                                  if (_pageState != 0) {
                                    _pageState = 0;
                                  } else {
                                    _pageState = 1;
                                  }
                                });
                              }
                            : _requestNoItmesModel,
                        splashColor: Colors.black,
                        child: Container(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                '\$ 00.00',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: 40,
                                    height: 22,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      'USA',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    'Order',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          AnimatedContainer(
            alignment: Alignment.center,
            width: orientation ? size.width * .4 : null,
            height: orientation ? size.height * .8 : null,
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(milliseconds: 1000),
            transform: Matrix4.translationValues(
                orderSummeryXOffset, orderSummeryYOffset, 1),
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
                      _buildHeaderTitle(size, "Your Order Summary(Dine In)"),
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
                                return Slidable(
                                  actionExtentRatio: 0.25,
                                  actionPane: SlidableStrechActionPane(),
                                  secondaryActions: [
                                    IconSlideAction(
                                      caption: 'Delete',
                                      color: kPrimaryColor,
                                      icon: Icons.delete,
                                      onTap: () {
                                        deleteItems(
                                                saleMasterId:
                                                    widget.saleMasterId,
                                                saleDetailId: data.saleDetailId)
                                            .then((value) => print(value));
                                      },
                                    ),
                                    IconSlideAction(
                                      caption: 'More',
                                      color: Colors.grey[350],
                                      icon: Icons.more_horiz,
                                      onTap: () {},
                                    ),
                                  ],
                                  child: Container(
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
                                    padding:
                                        EdgeInsets.fromLTRB(15, 10, 15, 10),
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
                                                        CrossAxisAlignment
                                                            .center,
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
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                            Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 1,
                                                  color: Colors.black54,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              child: Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      _pageState = 2;
                                                    });
                                                    print(data);
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            1.0),
                                                    child: Text(
                                                      "SPECIAL REQUEST",
                                                      style: TextStyle(
                                                        fontSize: 8,
                                                        fontFamily:
                                                            'San-francisco',
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
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
                      _buildButtonContainer(size, context)
                    ],
                  ),
                ),
                _pageState == 1 ? _buildCancelButton(context) : Container()
              ],
            ),
          ),
          AnimatedContainer(
            margin: EdgeInsets.only(left: orientation ? size.width * .013 : 0),
            width: orientation ? size.width * .37 : size.width,
            height: showNoteHeight,
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(milliseconds: 1000),
            transform: Matrix4.translationValues(0, showNoteYOffset, 1),
            decoration: BoxDecoration(
                color: Colors.transparent,
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
            child: Stack(
              children: <Widget>[
                Container(
                  height: orientation ? size.height * 0.8 : double.infinity,
                  width: orientation ? size.width * 0.4 : double.infinity,
                  color: orientation ? null : Colors.white,
                  child: Column(
                    children: <Widget>[
                      _buildHeaderTitle(size, "Special Request"),
                      Container(
                        height: orientation
                            ? size.height * 0.52
                            : size.height * 0.5,
                        color: Colors.white,
                        child: FutureBuilder(
                          future: noteList,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return CenterLoadingIndicator();
                            }
                            return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                var data = snapshot.data[index];
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 30,
                                  ),
                                  height: 60,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 0.2,
                                        color: Colors.grey[350],
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        data.noteName.toString(),
                                        style: TextStyle(
                                          fontFamily: 'San-francisco',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerRight,
                                          child: Checkbox(
                                            activeColor: kPrimaryColor,
                                            checkColor: Colors.white,
                                            value:
                                                data.noteId == 1 ? true : false,
                                            onChanged: (val) {
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Container(
                        height: orientation
                            ? size.height * 0.1
                            : size.height * 0.08,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Button(
                              buttonName: "Reset",
                              border: true,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Button(
                              buttonName: "Apply",
                              press: () {},
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
        ],
      )),
    );
  }

  // special Request___________________________________

  _buildSpecilRequest(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.black54,
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
                color: Colors.black,
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

  _buildHeaderTitle(size, title) {
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
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  _buildButtonContainer(size, BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return Container(
      height: orientation == Orientation.landscape
          ? size.height * 0.1
          : size.height * 0.08,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Button(
            buttonName: "Print Bill",
          ),
          SizedBox(
            width: 10,
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
    );
  }

// ___________________________ Internal Widget____________________________________________________

  _buildImageContainer(bool orientation, Size size, tableList, int index) {
    return Container(
      child: FadeInImage.assetNetwork(
        placeholder: preLoading,
        image: serverIP + tableList[index].image,
        height: orientation ? size.height * .15 : size.height * .1,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  _buildMainFloorTab(AsyncSnapshot snapshot, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
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
            height: 75,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 1.5,
                ),
              ),
            ),
            child: Image.network(
              serverIP + snapshot.data[index].photo,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            snapshot.data[index].typeName,
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

  _buildContainerData(bool orientation, Size size, tableList, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: orientation ? size.height * .01 : 3,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                tableList[index].itemName,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff121010),
                  fontFamily: "San-francisco",
                  fontWeight: FontWeight.bold,
                  fontSize: orientation ? 15 : 14,
                ),
              ),
              SizedBox(
                height: orientation ? size.height * .005 : 1,
              ),
              Text(
                '\$ ${tableList[index].price}',
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kPrimaryColor,
                  fontFamily: "San-francisco",
                  fontWeight: FontWeight.bold,
                  fontSize: orientation ? 13 : 14,
                ),
              ),
            ],
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
        snapshot.data[index].typeName,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          fontFamily: 'San-francisco',
        ),
      ),
    );
  }
}
