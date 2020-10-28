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
// Future<List<Ordersummery>> orderSummery;
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

  // showSumeryModal({tableList}) {
  //   tableName = tableList.tableName;
  //   tableId = tableList.tableId;
  //   saleMasterId = tableList.saleMasterId;
  //   orderSummery = fetchOrderSummery(
  //     table_id: tableList.tableId,
  //     sale_master_id: tableList.saleMasterId,
  //   );
  //   setState(() {
  //     if (_pageState != 0) {
  //       _pageState = 0;
  //     } else {
  //       _pageState = 1;
  //     }
  //   });
  // }

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

    SwitchContainer.windowHeight = size.height;
    SwitchContainer.windowWidth = size.width;
    SwitchContainer().rederAnimateContainer(
      orientation: orientation,
      size: size,
      pageState: _pageState,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: size.height,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
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
                      indicatorColor: Color(0xffb01105),
                      tabsWidth: size.width <= 400.0
                          ? size.height * .1
                          : size.width >= 1000.0
                              ? size.height * .13
                              : size.height * .09,
                      selectedTabBackgroundColor: null,
                      contentScrollAxis: Axis.vertical,
                      tabs: List.generate(
                        snapshot.data.length,
                        (index) {
                          return Tab(
                            child: _buildMainFloorTab(snapshot, index),
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
                                    padding: EdgeInsets.all(1),
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    childAspectRatio: size.width <= 400.0
                                        ? size.height / 800
                                        : size.width >= 1000.0
                                            ? size.height / 900
                                            : size.height / 1000,
                                    crossAxisCount: size.width <= 800.0
                                        ? 2
                                        : size.width >= 1000.0 ? 5 : 4,
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
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              width: 1.3,
                                              color: Color(
                                                0xff0f0808,
                                              ),
                                            ),
                                          ),
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
      width: double.infinity,
      height: orientation ? size.height * .14 : size.height * .08,
      child: CachedNetworkImage(
        imageUrl: serverIP + tableList[index].tableImage,
        placeholder: (context, url) => CenterLoadingIndicator(),
        errorWidget: (context, url, error) => Container(
          height: orientation ? size.height * .14 : size.height * .06,
          child: Icon(
            Icons.no_sim,
            color: Colors.grey[500],
            size: orientation ? 50 : 30,
          ),
        ),
      ),
    );
  }

  _buildMainFloorTab(AsyncSnapshot snapshot, int index) {
    return Container(
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
              height: 60,
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

  // orderSummery inner_width________________________
}
