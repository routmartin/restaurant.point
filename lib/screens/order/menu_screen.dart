import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:network_image_to_byte/network_image_to_byte.dart';
import 'package:path_provider/path_provider.dart';
import 'package:platform_action_sheet/platform_action_sheet.dart';

import 'package:pointrestaurant/models/menu.dart';
import 'package:pointrestaurant/models/move_list.dart';
import 'package:pointrestaurant/models/note.dart';
import 'package:pointrestaurant/models/ordersummery.dart';
import 'package:pointrestaurant/screens/payment/payment_screen.dart';
import 'package:pointrestaurant/services/list_note.dart';
import 'package:pointrestaurant/services/table_model/delete.dart';
import 'package:pointrestaurant/services/table_model/menu_service.dart';
import 'package:pointrestaurant/services/table_model/discount_sevice.dart';
import 'package:pointrestaurant/services/table_model/move_sevice.dart';
import 'package:pointrestaurant/services/table_model/order_items.dart';
import 'package:pointrestaurant/services/table_model/order_summery_sevice.dart';
import 'package:pointrestaurant/services/table_model/print_sevices.dart';

import 'package:pointrestaurant/utilities/path.dart';
import 'package:pointrestaurant/utilities/style.main.dart';
import 'package:pointrestaurant/utilities/switch.cofig.dart';
import 'package:pointrestaurant/widget/botton_middle_button.dart';
import 'package:pointrestaurant/widget/center_loading_indecator.dart';
import 'package:vertical_tabs/vertical_tabs.dart';

import 'components/event_button.dart';

import 'components/order_cal_icon.dart';

import 'components/vertical_tab_container.dart';

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
  Future<List<MoveList>> movelistData;
  Future<List<Ordersummery>> orderSummery;
  Future<List<Note>> noteList;
  List growableList = [];
  final f = new NumberFormat("#,##0.00");
  //_______________ OrderSummery _________________
  int totalItems = 0;
  double totalAmount = 0;
  // ignore: non_constant_identifier_names
  int sale_detail_id;
  int restoreSaleMasterId;
  //_______________ Overide Authenticator_________________
  String username;
  String password;
  // ignore: non_constant_identifier_names
  String txt_percent;
  // ignore: non_constant_identifier_names
  String txt_reason;
  bool move_with_auth = false;
  bool hasNote = false;

  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  List<BluetoothDevice> _devices = [];
  BluetoothDevice _device;
  List<String> imgArr = new List();
  // var pathImage = '';
  int done = 1;
  String tmpPath = '';
  int _pageState = 0;
  final ValueNotifier<int> _selectItems = ValueNotifier<int>(0);
  final ValueNotifier<double> _totalAmount = ValueNotifier<double>(0);
  //_______________________________________________________________
  @override
  void initState() {
    super.initState();
    restoreSaleMasterId = widget.saleMasterId;
    requestMenuFunction();
    requestOrderSummeryFunction();
  }

  requestMenuFunction() {
    menuData = fetchMenuSevice(saleMasterId: restoreSaleMasterId);
  }

  requestOrderSummeryFunction() async {
    orderSummery = fetchOrderSummery(
      table_id: widget.tableId,
      sale_master_id: restoreSaleMasterId,
    ).then((value) {
      _selectItems.value = value.length;
      totalAmount = 0;
      value.forEach((element) {
        totalAmount += double.parse(element.amount);
      });
      _totalAmount.value = totalAmount;
      return value;
    });
    setState(() {});
  }

  // ___________________________________ Section Work with M1 ______________________________________________

  void _connect() {
    if (_device == null) {
      print('Device Not');
    } else {
      bluetooth.isConnected.then((isConnected) {
        if (!isConnected) {
          bluetooth.connect(_device).catchError((error) {});
        }
      });
    }
  }

  void _disconnect() {
    bluetooth.disconnect();
  }

  Future<void> initPlatformState() async {
    List<BluetoothDevice> devices = [];
    try {
      devices = await bluetooth.getBondedDevices();
    } on PlatformException {}

    if (!mounted) return;
    setState(() {
      _devices = devices;
      _device = _devices[0];
      _connect();
    });
  }

  Future<Uint8List> _networkImageToByte(int target) async {
    String path = '$serverIP/temp/$target.png';
    Uint8List byteImage = await networkImageToByte(path);
    return byteImage;
  }

  Future initSaveToPath(int target) async {
    imgArr.clear();
    Uint8List bytes = await _networkImageToByte(target);
    final tempDir = (await getApplicationDocumentsDirectory()).path;
    imgArr.add('$tempDir/$target.png');
    tmpPath = tempDir;
    final file = await new File('$tempDir/$target.png').create();
    file.writeAsBytesSync(bytes);
  }

  void printWithM1(int index) async {
    for (int i = 0; i < index; i++) {
      bluetooth.isConnected.then((isConnected) {
        if (isConnected) {
          bluetooth.printImage('$tmpPath/${i + 1}.png');
          if (index == i + 1) {
            bluetooth.printNewLine();
            bluetooth.printNewLine();
            bluetooth.printNewLine();
            bluetooth.paperCut();
            _disconnect();
            Navigator.pop(context);
          }
        }
      });
    }
  }

  // ___________________________________ Section Work with M1 ______________________________________________

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

    backToPreviewPage() {
      Navigator.pop(context, true);
    }

    printingLoadingIndicator() {
      return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            content: Container(
              width: 200,
              height: 300,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Image.asset('assets/icons/printing.gif'),
                    CircularProgressIndicator(
                      backgroundColor: kPrimaryColor,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    showMessageDialog({message = 'NO ORDER ITEMS'}) {
      Timer timer = Timer(Duration(milliseconds: 1000), () {
        Navigator.of(context, rootNavigator: true).pop();
      });
      return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.9),
        transitionDuration: Duration(milliseconds: 100),
        barrierDismissible: false,
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
                      child: Text(
                        message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'San-francisco',
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    confirmationDialog({String tableName, int tableId}) {
      return showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text(
              'CONFIRM MOVE TO TABLE : ' + tableName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'San-francisco',
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            content: Container(
              width: orientation ? size.width * .35 : size.width * .8,
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(7),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  splashColor: Colors.black12,
                                  child: Container(
                                    width: orientation
                                        ? size.width * .14
                                        : size.width * .27,
                                    height: 45.0,
                                    alignment: Alignment.center,
                                    decoration:
                                        BoxDecoration(color: Colors.black12),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 9,
                                      horizontal: 20,
                                    ),
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                        fontSize: 13,
                                        decoration: TextDecoration.none,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(7),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  splashColor: Colors.black12,
                                  onTap: () {
                                    movetoTable(
                                      saleMasterId: restoreSaleMasterId,
                                      tableId: tableId,
                                    ).then((_) {
                                      if (move_with_auth) {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        backToPreviewPage();
                                      } else {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        backToPreviewPage();
                                      }
                                    });
                                  },
                                  child: Container(
                                    height: 45.0,
                                    width: orientation
                                        ? size.width * .14
                                        : size.width * .27,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 9,
                                      horizontal: 20,
                                    ),
                                    child: Text(
                                      'Move',
                                      style: TextStyle(
                                        fontSize: 13,
                                        decoration: TextDecoration.none,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    showMovableDialog({int salMasterID}) {
      return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.2),
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
                  width: orientation ? size.width * 0.8 : size.width * 1.1,
                  height: orientation ? size.height * .9 : size.height * .7,
                  child: FutureBuilder(
                    future: movelistData,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return CenterLoadingIndicator();
                      }
                      return SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Available Table'.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'San-francisco',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: orientation
                                  ? size.height * .75
                                  : size.height * .55,
                              child: VerticalTabs(
                                indicatorColor: Color(0xffb01105),
                                tabsWidth: orientation
                                    ? size.width * .12
                                    : size.width * .23,
                                selectedTabBackgroundColor: null,
                                contentScrollAxis: Axis.vertical,
                                tabs: List.generate(
                                  snapshot.data.length,
                                  (index) {
                                    return Tab(
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 55,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                        ),
                                        child: Text(
                                          snapshot.data[index].floorName,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xff121010),
                                            fontFamily: "San-francisco",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                contents: List.generate(
                                  snapshot.data.length,
                                  (index) {
                                    List<TableMove> tableList =
                                        snapshot.data[index].tables;
                                    return Container(
                                      color: Color(0xfff5f5f5),
                                      padding: EdgeInsets.all(10),
                                      child: GridView.count(
                                        shrinkWrap: true,
                                        physics: ScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        mainAxisSpacing: 20,
                                        crossAxisSpacing: 20,
                                        childAspectRatio: orientation
                                            ? size.height / 950
                                            : size.height / 1000,
                                        crossAxisCount: size.width <= 800.0
                                            ? 2
                                            : size.width >= 1000.0 ? 5 : 4,
                                        children: List<Widget>.generate(
                                          tableList.length,
                                          (index) {
                                            return Container(
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
                                                  onTap: () =>
                                                      confirmationDialog(
                                                    tableName: tableList[index]
                                                        .tableName,
                                                    tableId: tableList[index]
                                                        .tableId,
                                                  ),
                                                  child: Column(
                                                    children: <Widget>[
                                                      CachedNetworkImage(
                                                        width: double.infinity,
                                                        height: orientation
                                                            ? size.height * .15
                                                            : size.height * .1,
                                                        fit: BoxFit.cover,
                                                        imageUrl: serverIP +
                                                            tableList[index]
                                                                .tableImage,
                                                        placeholder: (context,
                                                                url) =>
                                                            CircularProgressIndicator(),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Container(
                                                          height: orientation
                                                              ? size.height *
                                                                  .14
                                                              : size.height *
                                                                  .06,
                                                          child: Icon(
                                                            Icons.no_sim,
                                                            color: Colors
                                                                .grey[500],
                                                            size: orientation
                                                                ? 50
                                                                : 30,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
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
                                                            SizedBox(
                                                              height: orientation
                                                                  ? size.height *
                                                                      .01
                                                                  : 3,
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
                                                                            ? 15
                                                                            : 14,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    showDiscountDialog({title, int id, int runFunction}) {
      txt_percent = null;
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Text(
                'DISCOUNT ($title)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'San-francisco',
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              content: Container(
                padding: EdgeInsets.all(10),
                width: orientation ? size.width * .4 : size.width * .95,
                height: orientation ? size.height * .2 : size.height * .25,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: size.width * .8,
                        height: 50.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: TextFormField(
                            onChanged: (val) {
                              txt_percent = val;
                            },
                            keyboardType: TextInputType.number,
                            autofocus: true,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(15.0),
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Colors.grey[200],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(7),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    splashColor: Colors.black12,
                                    child: Container(
                                      width: orientation
                                          ? size.width * .14
                                          : size.width * .27,
                                      height: 45.0,
                                      alignment: Alignment.center,
                                      decoration:
                                          BoxDecoration(color: Colors.black12),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 9,
                                        horizontal: 20,
                                      ),
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                          fontSize: 13,
                                          decoration: TextDecoration.none,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(7),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      if (txt_percent != null) {
                                        switch (runFunction) {
                                          case 0:
                                            applyPercentDisItem(
                                                    saleDetailId: id,
                                                    dis_percent_item:
                                                        txt_percent)
                                                .then(
                                              (_) {
                                                Navigator.pop(context);
                                              },
                                            );
                                            break;
                                          case 1:
                                            applyPercentDollItem(
                                              saleDetailId: id,
                                              dis_cash_item: txt_percent,
                                            ).then(
                                              (_) => Navigator.pop(context),
                                            );
                                            break;
                                          case 2:
                                            applyDiscountCashonInvoice(
                                              sale_master_id: id,
                                              dis_cash_inv: txt_percent,
                                            ).then(
                                              (_) => Navigator.pop(context),
                                            );
                                            break;
                                          case 3:
                                            applyDiscountPercentonInvoice(
                                              sale_master_id: id,
                                              dis_percent_inv: txt_percent,
                                            ).then(
                                              (_) => Navigator.pop(context),
                                            );
                                            break;
                                          default:
                                        }
                                      }
                                    },
                                    splashColor: Colors.black12,
                                    child: Container(
                                      height: 45.0,
                                      width: orientation
                                          ? size.width * .14
                                          : size.width * .27,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: kPrimaryColor,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 9,
                                        horizontal: 20,
                                      ),
                                      child: Text(
                                        'Confirm',
                                        style: TextStyle(
                                          fontSize: 13,
                                          decoration: TextDecoration.none,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
    }

    _showAuthenticator({
      int saleMasterId,
      int saleDetailId,
      int callFun,
    }) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            content: Container(
              padding: EdgeInsets.all(10),
              width: orientation ? size.width * .4 : size.width * .95,
              height: orientation ? size.height * .38 : size.height * .35,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      height: size.height * .06,
                    ),
                    Text(
                      'No Permission'.toUpperCase(),
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'San-francisco',
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    SizedBox(
                      height: size.height * .05,
                    ),
                    Container(
                      width: size.width * .9,
                      height: 50.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: TextFormField(
                          onChanged: (val) => username = val,
                          decoration: InputDecoration(
                            hintText: 'Username',
                            contentPadding: EdgeInsets.all(15.0),
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .035,
                    ),
                    Container(
                      width: size.width * .8,
                      height: 50.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: TextFormField(
                          onChanged: (val) {
                            password = val;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            contentPadding: EdgeInsets.all(15.0),
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 10, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          splashColor: Colors.black12,
                          child: Container(
                            width: orientation
                                ? size.width * .14
                                : size.width * .27,
                            height: 45.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: Colors.black12),
                            padding: EdgeInsets.symmetric(
                              vertical: 9,
                              horizontal: 20,
                            ),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: 13,
                                decoration: TextDecoration.none,
                                color: Colors.black54,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            if (username != null && password != null) {
                              if (callFun == 0) {
                                overideDeleteItems(
                                  saleDetailId: saleDetailId,
                                  saleMasterId: restoreSaleMasterId,
                                  username: username,
                                  password: password,
                                ).then((response) {
                                  if (response == 'success') {
                                    requestOrderSummeryFunction();
                                    Navigator.pop(context);
                                  } else if (response == 'failed') {
                                    showMessageDialog(
                                        message: 'CAN NOT DELETE THIS');
                                  }
                                });
                              } else if (callFun == 1) {
                                overideVoidInvice(
                                  saleMasterId: restoreSaleMasterId,
                                  username: username,
                                  password: password,
                                  reason: txt_reason,
                                ).then((response) {
                                  if (response == 'success') {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    backToPreviewPage();
                                  } else if (response == 'noPermission') {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    showMessageDialog(message: 'NO PERMISSION');
                                  }
                                });
                              } else if (callFun == 2) {
                                requestAuthorizationMoveTable(
                                  userName: username,
                                  passWord: password,
                                  saleMasterId: saleMasterId,
                                ).then((data) {
                                  if (data == 'success') {
                                    move_with_auth = true;
                                    movelistData = fetchMoveList();
                                    showMovableDialog(
                                      salMasterID: restoreSaleMasterId,
                                    );
                                  } else {}
                                });
                              }
                            } else {
                              print('no data');
                            }
                          },
                          splashColor: Colors.black12,
                          child: Container(
                            height: 45.0,
                            width: orientation
                                ? size.width * .14
                                : size.width * .27,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 9,
                              horizontal: 20,
                            ),
                            child: Text(
                              'Overide',
                              style: TextStyle(
                                fontSize: 13,
                                decoration: TextDecoration.none,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      );
    }

    requestToVoidInvoid() {
      return showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text(
              'REQUEST TO VOID INVOICE',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'San-francisco',
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            content: Container(
              width: orientation ? size.width * .35 : size.width * .8,
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: size.width * .8,
                      height: size.height * .15,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: TextField(
                          onChanged: (txt) {
                            if (txt != null) {
                              txt_reason = txt;
                            }
                          },
                          maxLines: 4,
                          keyboardType: TextInputType.text,
                          autofocus: true,
                          decoration: InputDecoration(
                            hintText: 'Please give the reason',
                            contentPadding: EdgeInsets.all(15.0),
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(7),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  splashColor: Colors.black12,
                                  child: Container(
                                    width: orientation
                                        ? size.width * .14
                                        : size.width * .27,
                                    height: 45.0,
                                    alignment: Alignment.center,
                                    decoration:
                                        BoxDecoration(color: Colors.black12),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 9,
                                      horizontal: 20,
                                    ),
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                        fontSize: 13,
                                        decoration: TextDecoration.none,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(7),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  splashColor: Colors.black12,
                                  onTap: () {
                                    if (txt_reason != null) {
                                      requestToVoidInvoice(
                                              saleMasterId: restoreSaleMasterId,
                                              reason: txt_reason)
                                          .then((data) {
                                        print(data);
                                        if (data == 'success') {
                                          backToPreviewPage();
                                          Navigator.pop(context, true);
                                        } else if (data == 'voidBeforePaid' ||
                                            data == 'voidAfterPaid') {
                                          _showAuthenticator(
                                            saleMasterId: restoreSaleMasterId,
                                            callFun: 1,
                                          );
                                        }
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: 45.0,
                                    width: orientation
                                        ? size.width * .14
                                        : size.width * .27,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 9,
                                      horizontal: 20,
                                    ),
                                    child: Text(
                                      'VOID',
                                      style: TextStyle(
                                        fontSize: 13,
                                        decoration: TextDecoration.none,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
    // ___________________________Open operation function ____________________________

    showActionBottomSheet({saleDetailId}) {
      return PlatformActionSheet().displaySheet(context: context, actions: [
        ActionSheetAction(
          text: "Order Now",
          onPressed: () {
            printtoKitchen(
              table_name: widget.tableName,
              sale_master_id: restoreSaleMasterId,
              sale_detail_ids: saleDetailId,
            ).then((value) => print(value));
          },
        ),
        ActionSheetAction(
          text: "Discount (%)",
          onPressed: () =>
              showDiscountDialog(title: '%', id: saleDetailId, runFunction: 0),
        ),
        ActionSheetAction(
          text: "Discount (\$)",
          onPressed: () =>
              showDiscountDialog(title: '\$', id: saleDetailId, runFunction: 1),
        ),
        // ActionSheetAction(
        //   text: "Split",
        //   onPressed: () => Navigator.pop(context),
        // ),
        ActionSheetAction(
          text: "Cancel",
          onPressed: () => Navigator.pop(context),
          isCancel: true,
          defaultAction: true,
        )
      ]);
    }
    // ___________________________Close operation function ____________________________

    // ____________________________Operation fucntion_____________________________
    reqestToDeleteItem({data}) {
      deleteItems(
        saleMasterId: restoreSaleMasterId,
        saleDetailId: data.saleDetailId,
      ).then((response) {
        if (response == 'success') {
          requestMenuFunction();
          requestOrderSummeryFunction();
        } else if (response == 'afterOrder' ||
            response == 'beforeOrder' ||
            response == 'afterBill') {
          _showAuthenticator(
            saleMasterId: widget.saleMasterId,
            saleDetailId: data.saleDetailId,
            callFun: 0,
          );
        }
      });
    }

    requestAddItemsFunction({tableList, int qty = 1}) {
      addOrderItems(
        itemDetailId: tableList.itemDetailId,
        saleMasterId: restoreSaleMasterId,
        tableId: widget.tableId,
        saleDetailId: tableList.saleDetailId,
        qty: qty,
      ).then((saleMasterId) {
        restoreSaleMasterId = int.parse(saleMasterId);
        requestMenuFunction();
        requestOrderSummeryFunction();
      });
    }
    // ____________________________Operation fucntion_____________________________

    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  height: size.height,
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 80),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 10,
                              color: Colors.black12,
                            ),
                          ],
                        ),
                        child: Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                size: 20,
                              ),
                              onPressed: backToPreviewPage,
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                margin: EdgeInsets.only(right: 20),
                                child: Text(
                                  widget.tableName,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'San-francisco',
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: FutureBuilder(
                          future: menuData,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return CenterLoadingIndicator();
                            }
                            return VerticalTabs(
                              indicatorColor: Color(0xffb01105),
                              selectedTabBackgroundColor: Colors.transparent,
                              tabsWidth: orientation
                                  ? size.width * .09
                                  : size.width * .23,
                              contentScrollAxis: Axis.vertical,
                              tabs: List.generate(
                                snapshot.data.length,
                                (index) {
                                  return Tab(
                                    child: VerticalTabContainer(
                                      snapshot: snapshot,
                                      index: index,
                                    ),
                                  );
                                },
                              ),
                              contents: List.generate(
                                snapshot.data.length,
                                (index) {
                                  var tableList = snapshot.data[index].items;
                                  return Container(
                                    child: Column(
                                      children: <Widget>[
                                        _buildTitleHeader(snapshot, index),
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(top: 10),
                                            child: GridView.count(
                                              shrinkWrap: true,
                                              physics: ScrollPhysics(),
                                              scrollDirection: Axis.vertical,
                                              mainAxisSpacing: 5,
                                              childAspectRatio: orientation
                                                  ? size.height / 780
                                                  : size.height / 700,
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
                                                              requestAddItemsFunction(
                                                                tableList:
                                                                    tableList[
                                                                        index],
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
                                                                      0.09,
                                                              child:
                                                                  CaculateIcon(
                                                                      qty: tableList[
                                                                              index]
                                                                          .qty,
                                                                      funcMinus:
                                                                          () {
                                                                        requestAddItemsFunction(
                                                                          tableList:
                                                                              tableList[index],
                                                                          qty:
                                                                              -1,
                                                                        );
                                                                      },
                                                                      funcPlus:
                                                                          () {
                                                                        requestAddItemsFunction(
                                                                          tableList:
                                                                              tableList[index],
                                                                        );
                                                                      }),
                                                            )
                                                          : Container()
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  width: MediaQuery.of(context).size.width,
                  left: 1,
                  bottom: 0,
                  child: Container(
                    height: 70,
                    color: Color(0xffebebeb),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * .2,
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FittedBox(
                                child: Text(
                                  'Selected',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "San-francisco",
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff787878),
                                  ),
                                ),
                              ),
                              FittedBox(
                                child: Text(
                                  'Items',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "San-francisco",
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff787878),
                                  ),
                                ),
                              ),
                              FittedBox(
                                child: ValueListenableBuilder(
                                  valueListenable: _selectItems,
                                  builder: (context, int value, child) {
                                    return Text(
                                      value.toString(),
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .5,
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 1),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: FutureBuilder(
                            future: orderSummery,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.data != null) {
                                return ListView.builder(
                                  itemCount: snapshot.data.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    var data = snapshot.data[index];
                                    return Container(
                                      margin: EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: 10,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(data.name,
                                                style: TextStyle(
                                                  color: Colors.black87,
                                                )),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          GestureDetector(
                                            onTap: () =>
                                                reqestToDeleteItem(data: data),
                                            child: BottomMiddleButton(
                                              sign: Text(
                                                'x',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          VerticalDivider(
                                            color: Colors.black,
                                            width: 2.2,
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return Container(
                                  width: double.infinity,
                                  child: Center(
                                    child: Text(
                                      'No Items'.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w800,
                                        fontFamily: 'San-francisco',
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
                        onTap: restoreSaleMasterId != 0
                            ? () {
                                requestOrderSummeryFunction();
                                noteList = fetchListNote().then((value) {
                                  if (value.length > 0) {
                                    hasNote = true;
                                    return value;
                                  } else {
                                    hasNote = false;
                                    return null;
                                  }
                                });
                                _pageState = 1;
                              }
                            : showMessageDialog,
                        splashColor: Colors.black,
                        child: Container(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ValueListenableBuilder(
                                valueListenable: _totalAmount,
                                builder: (context, double value, child) {
                                  return Text(
                                    '\$ ${f.format(value)}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                height: 5,
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
                                      'USD',
                                      style: TextStyle(
                                        fontSize: 15,
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
            height: orientation ? size.height * .86 : null,
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(milliseconds: 1000),
            transform: Matrix4.translationValues(
              SwitchContainer.firstContainerXOffset,
              SwitchContainer.firstContainerYOffset,
              1,
            ),
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  offset: Offset(1, 4),
                  color: Colors.black12.withOpacity(.1),
                  blurRadius: 20,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        _buildHeaderTitle(size, "Your Order Summary"),
                        Container(
                          height: orientation
                              ? size.height * 0.42
                              : size.height * 0.4,
                          color: Color(0xfff0f0f0),
                          child: FutureBuilder(
                            future: orderSummery,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.data != null) {
                                return ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    var data = snapshot.data[index];
                                    return Slidable(
                                      actionExtentRatio: 0.25,
                                      actionPane: SlidableStrechActionPane(),
                                      secondaryActions: [
                                        IconSlideAction(
                                          caption: 'More',
                                          color: Colors.grey[350],
                                          icon: Icons.more_horiz,
                                          onTap: () => showActionBottomSheet(
                                            saleDetailId: data.saleDetailId,
                                          ),
                                        ),
                                        IconSlideAction(
                                          caption: 'Delete',
                                          color: kPrimaryColor,
                                          icon: Icons.delete,
                                          onTap: () {
                                            reqestToDeleteItem(data: data);
                                          },
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
                                                    child:
                                                        SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Text(
                                                            data.name,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'San-francisco',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
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
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.black,
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                CaculateIcon(
                                                    qty: data.qty,
                                                    funcMinus: () {
                                                      requestAddItemsFunction(
                                                        tableList: data,
                                                        qty: -1,
                                                      );
                                                    },
                                                    funcPlus: () {
                                                      requestAddItemsFunction(
                                                        tableList: data,
                                                      );
                                                    }),
                                                hasNote
                                                    ? Container(
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: data.notes
                                                                      .length <
                                                                  1
                                                              ? Border.all(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .black54,
                                                                )
                                                              : null,
                                                          color: data.notes
                                                                      .length >=
                                                                  1
                                                              ? kPrimaryColor
                                                              : null,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.0),
                                                        ),
                                                        child: Material(
                                                          color: Colors
                                                              .transparent,
                                                          child: InkWell(
                                                            splashColor:
                                                                Colors.black38,
                                                            onTap: () {
                                                              setState(() {
                                                                _pageState = 2;
                                                              });
                                                              growableList
                                                                  .clear();
                                                              for (int i = 0;
                                                                  i <
                                                                      data.notes
                                                                          .length;
                                                                  i++) {
                                                                growableList
                                                                    .add(
                                                                  data.notes[i]
                                                                      .noteId,
                                                                );
                                                              }
                                                              sale_detail_id = data
                                                                  .saleDetailId;
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                1.0,
                                                              ),
                                                              child: Text(
                                                                "SPECIAL REQUEST",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 8,
                                                                  fontFamily:
                                                                      'San-francisco',
                                                                  color: data.notes
                                                                              .length >=
                                                                          1
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : Container()
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return Container(
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SvgPicture.asset(
                                        noitemscart,
                                        fit: BoxFit.contain,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'No Items'.toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                          fontFamily: 'San-francisco',
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        Container(
                          height: size.height * 0.08,
                          color: Colors.grey[100],
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    ValueListenableBuilder(
                                      valueListenable: _selectItems,
                                      builder: (context, int value, child) {
                                        return Text(
                                          value.toString(),
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(height: 5),
                                    ValueListenableBuilder(
                                      valueListenable: _totalAmount,
                                      builder: (context, double value, child) {
                                        return Text(
                                          '\$ ${f.format(value)}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: kPrimaryColor,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 12,
                          ),
                          child: Column(
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Button(
                                    buttonName: "VOID",
                                    press: requestToVoidInvoid,
                                  ),
                                  Button(
                                    buttonName: "DISCOUNT (%)",
                                    press: () {
                                      showDiscountDialog(
                                        title: 'INVOICE %',
                                        id: restoreSaleMasterId,
                                        runFunction: 3,
                                      );
                                    },
                                  ),
                                  Button(
                                    buttonName: "DISCOUNT (\$)",
                                    press: () {
                                      showDiscountDialog(
                                        title: 'INVOICE \$',
                                        id: restoreSaleMasterId,
                                        runFunction: 2,
                                      );
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Button(
                                    buttonName: "MOVE",
                                    press: () {
                                      requestPermissionToMove().then((data) {
                                        if (data == 'moveTable') {
                                          _showAuthenticator(callFun: 2);
                                        } else if (data == 'success') {
                                          movelistData = fetchMoveList();
                                          showMovableDialog(
                                            salMasterID: restoreSaleMasterId,
                                          );
                                        }
                                      });
                                    },
                                  ),
                                  Button(
                                    buttonName: "KITCHAN",
                                    press: () {
                                      printtoKitchen(
                                        table_name: widget.tableName,
                                        sale_master_id: restoreSaleMasterId,
                                      ).then((value) {
                                        if (value == 'no_item_print') {
                                          showMessageDialog(
                                            message: 'Already Print to Kitchan',
                                          );
                                        }
                                      });
                                    },
                                  ),
                                  // Button(
                                  //   buttonName: "PRINT BILL",
                                  //   press: () => printBill(
                                  //       sale_master_id: restoreSaleMasterId),
                                  // ),
                                  Button(
                                    buttonName: "PRINT BILL",
                                    press: () => printBillWithM1(
                                      sale_master_id: restoreSaleMasterId,
                                    ).then((index) {
                                      printingLoadingIndicator();
                                      initPlatformState();
                                      done = 1;
                                      for (int i = 1; i <= index; i++) {
                                        initSaveToPath(i).then(
                                          (_) {
                                            done++;
                                            if (done == index) {
                                              Future.delayed(
                                                  const Duration(
                                                      milliseconds: 3000), () {
                                                printWithM1(index);
                                              });
                                            }
                                          },
                                        );
                                      }
                                    }),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 15,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => PaymentScreen(
                                              saleMasterId: restoreSaleMasterId,
                                            ),
                                          ),
                                        );
                                      },
                                      splashColor:
                                          kPrimaryColor.withOpacity(.5),
                                      child: Container(
                                        width: double.infinity,
                                        height: 55,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: kPrimaryColor,
                                            width: 1.3,
                                          ),
                                        ),
                                        child: Text(
                                          'PAYMENT',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: kPrimaryColor,
                                            fontFamily: 'San-francisco',
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _pageState == 1 ? _buildCancelButton(context) : Container()
              ],
            ),
          ),
          hasNote
              ? AnimatedContainer(
                  margin: EdgeInsets.only(
                      left: orientation ? size.width * .013 : 0),
                  width: orientation ? size.width * .37 : size.width,
                  height: SwitchContainer.secondContainerHeight,
                  curve: Curves.fastLinearToSlowEaseIn,
                  duration: Duration(milliseconds: 1000),
                  transform: Matrix4.translationValues(
                      0, SwitchContainer.seconndContainerYOffset, 1),
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
                        height:
                            orientation ? size.height * 0.8 : double.infinity,
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
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CenterLoadingIndicator();
                                  }
                                  return ListView.builder(
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, index) {
                                      var data = snapshot.data[index];
                                      return Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {
                                            if (growableList
                                                .contains(data.noteId)) {
                                              growableList.remove(data.noteId);
                                            } else {
                                              growableList.add(data.noteId);
                                              growableList =
                                                  growableList.toSet().toList();
                                            }
                                            setState(() {});
                                          },
                                          splashColor: Colors.black12,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 30,
                                            ),
                                            height: 55,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                  width: 0.4,
                                                  color: Colors.grey[400],
                                                ),
                                              ),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Checkbox(
                                                    activeColor: kPrimaryColor,
                                                    checkColor: Colors.white,
                                                    value: growableList.any(
                                                      (element) =>
                                                          element ==
                                                          data.noteId,
                                                    ),
                                                    onChanged: (val) {},
                                                  ),
                                                ),
                                                Expanded(
                                                    child: Row(
                                                  children: <Widget>[
                                                    Text(
                                                      data.noteName.toString(),
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'San-francisco',
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        data.notePrice
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'San-francisco',
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          fontSize: 13,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                              ],
                                            ),
                                          ),
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
                                    press: () {
                                      growableList.clear();
                                      setState(() {});
                                    },
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Button(
                                    buttonName: "Apply",
                                    press: () {
                                      applySpecialRequest(
                                        noteList: growableList,
                                        saleMasterId: restoreSaleMasterId,
                                        saleDetailId: sale_detail_id,
                                      ).then((value) {
                                        if (value == 'success') {
                                          _pageState = 1;
                                          requestOrderSummeryFunction();
                                        }
                                      });
                                    },
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      _pageState == 2
                          ? _buildCancelButton(context)
                          : Container()
                    ],
                  ),
                )
              : Container(),
        ],
      )),
    );
  }

  _buildCancelButton(BuildContext context) {
    return Positioned(
      top: 12,
      right: 8,
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

// ___________________________ Internal Widget____________________________________________________

  _buildImageContainer(bool orientation, Size size, tableList, int index) {
    return Container(
      width: double.infinity,
      height: orientation ? size.height * .15 : size.height * .14,
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: serverIP + tableList[index].image,
        placeholder: (context, url) => CenterLoadingIndicator(),
        errorWidget: (context, url, error) => Container(
          height: orientation ? size.height * .14 : size.height * .06,
          child: Icon(
            Icons.no_sim,
            color: Colors.grey[500],
            size: orientation ? 50 : 50,
          ),
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
          SizedBox(
            height: orientation ? size.height * .01 : 5,
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
                height: orientation ? size.height * .005 : 10,
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
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Text(
        snapshot.data[index].typeName,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          fontFamily: 'San-francisco',
        ),
      ),
    );
  }
}
