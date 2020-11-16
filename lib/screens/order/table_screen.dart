import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pointrestaurant/models/floor.dart';
import 'package:pointrestaurant/services/table_model/table_service.dart';
import 'package:pointrestaurant/utilities/path.dart';
import 'package:pointrestaurant/utilities/style.main.dart';
import 'package:pointrestaurant/utilities/switch.cofig.dart';
import 'package:pointrestaurant/widget/center_loading_indecator.dart';
import 'package:pointrestaurant/widget/company_header.dart';
import 'package:vertical_tabs/vertical_tabs.dart';
import 'menu_screen.dart';

class TableModeScreen extends StatefulWidget {
  @override
  _TableModeScreenState createState() => _TableModeScreenState();
}

class _TableModeScreenState extends State<TableModeScreen> {
  Future<List<Floor>> floorData;
//________________Open Switch Container Layout________________________

  int _pageState = 0;
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

  _fetchTableData() {
    setState(() {
      floorData = fetchDataFloors();
    });
  }

  // ignore: non_constant_identifier_names
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
    ).then((value) => value ? _fetchTableData() : null);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool orientation =
        MediaQuery.of(context).orientation == Orientation.landscape;
    SwitchContainer.windowHeight = size.height;
    SwitchContainer.windowWidth = size.width;
    SwitchContainer().rederAnimateContainer(
      orientation: orientation,
      size: size,
      pageState: _pageState,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _fetchTableData(),
        backgroundColor: Colors.white,
        disabledElevation: 0.5,
        child: Icon(
          Icons.refresh,
          color: Colors.black,
        ),
      ),
      body: Container(
        height: size.height,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            size.width < 350
                ? SizedBox(
                    height: 10,
                  )
                : size.width >= 1000
                    ? SizedBox(
                        height: 25,
                      )
                    : SizedBox(
                        height: 30,
                      ),
            CampanyHeaderContianer(),
            Expanded(
              child: FutureBuilder(
                future: floorData,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CenterLoadingIndicator());
                  }
                  return Container(
                    width: double.infinity,
                    height: size.height,
                    child: VerticalTabs(
                      indicatorColor: kPrimaryColor,
                      selectedTabBackgroundColor: Colors.transparent,
                      tabsWidth: size.width <= 360.0
                          ? size.width * .2
                          : size.width <= 400.0
                              ? size.width * .22
                              : size.width >= 1000.0
                                  ? size.width * .08
                                  : size.width * .22,
                      contentScrollAxis: Axis.vertical,
                      tabs: List.generate(
                        snapshot.data.length,
                        (index) {
                          return Tab(
                            child: _buildMainFloorTab(snapshot, index, size),
                          );
                        },
                      ),
                      contents: List.generate(
                        snapshot.data.length,
                        (index) {
                          var tableList = snapshot.data[index].tables;
                          return Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: GridView.count(
                                    padding: EdgeInsets.only(top: 1),
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    mainAxisSpacing: 10,
                                    scrollDirection: Axis.vertical,
                                    childAspectRatio: size.width <= 360.0
                                        ? size.height / 780
                                        : size.width <= 400.0
                                            ? size.height / 900
                                            : size.width >= 1200.0
                                                ? size.height / 1000
                                                : size.height / 1000,
                                    crossAxisCount: size.width <= 500.0
                                        ? 2
                                        : size.width >= 1000.0 ? 6 : 5,
                                    children: List<Widget>.generate(
                                      tableList.length,
                                      (index) {
                                        return Container(
                                          margin: orientation
                                              ? EdgeInsets.only(
                                                  bottom: 15,
                                                  right: 10,
                                                  left: 10,
                                                )
                                              : EdgeInsets.only(
                                                  bottom: 10,
                                                  right: 5,
                                                  left: 5,
                                                ),
                                          decoration: cardDecoration,
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              splashColor: Colors.black12,
                                              onTap: () => pushToMenuScree(
                                                sale_master_id: tableList[index]
                                                    .saleMasterId,
                                                table_id:
                                                    tableList[index].tableId,
                                                table_name:
                                                    tableList[index].tableName,
                                              ),
                                              child: Container(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Container(
                                                      width: double.infinity,
                                                      height: size.width <=
                                                              360.0
                                                          ? size.height * .11
                                                          : size
                                                                      .width <=
                                                                  400.0
                                                              ? size
                                                                      .height *
                                                                  .115
                                                              : size
                                                                          .width >=
                                                                      1000.0
                                                                  ? size.height *
                                                                      .18
                                                                  : size.height *
                                                                      .13,
                                                      child: CachedNetworkImage(
                                                        imageUrl: serverIP +
                                                            tableList[index]
                                                                .tableImage,
                                                        placeholder: (context,
                                                                url) =>
                                                            CenterLoadingIndicator(),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Image.asset(
                                                                'assets/images/table.jpg'),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 10,
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            tableList[index]
                                                                        .tableStatus !=
                                                                    'free'
                                                                ? SizedBox(
                                                                    height: orientation
                                                                        ? size.height *
                                                                            .015
                                                                        : 4,
                                                                  )
                                                                : SizedBox(
                                                                    height: orientation
                                                                        ? size.height *
                                                                            .03
                                                                        : 12,
                                                                  ),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  tableList[
                                                                          index]
                                                                      .tableName,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color(
                                                                        0xff121010),
                                                                    fontFamily:
                                                                        "San-francisco",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        orientation
                                                                            ? 18
                                                                            : 11,
                                                                  ),
                                                                ),
                                                                tableList[index]
                                                                            .tableStatus !=
                                                                        'free'
                                                                    ? SizedBox(
                                                                        height: orientation
                                                                            ? size.height *
                                                                                .015
                                                                            : 4,
                                                                      )
                                                                    : SizedBox(
                                                                        height: orientation
                                                                            ? size.height *
                                                                                .014
                                                                            : 3,
                                                                      ),
                                                                tableList[index]
                                                                            .tableStatus !=
                                                                        'free'
                                                                    ? Container(
                                                                        padding: EdgeInsets.symmetric(
                                                                            vertical:
                                                                                3,
                                                                            horizontal:
                                                                                6),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              kPrimaryColor,
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
                                                                        ),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            tableList[index].checkinDuration,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(
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
                                                      ),
                                                    )
                                                  ],
                                                ),
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
    );
  }

  _buildMainFloorTab(AsyncSnapshot snapshot, int index, Size size) {
    return Container(
      height: size.width <= 360.0
          ? size.height * .13
          : size.width <= 400.0
              ? size.height * .14
              : size.width >= 1000.0 ? size.height * .18 : size.height * .14,
      decoration: cardDecoration,
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: size.width <= 360.0
                ? size.height * .11
                : size.width <= 400.0
                    ? size.height * .09
                    : size.width >= 1000.0
                        ? size.height * .12
                        : size.height * .09,
            child: Image.asset(
              floor,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: Text(
                snapshot.data[index].floorName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 0.7,
                  fontFamily: "San-francisco",
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
