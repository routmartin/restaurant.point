import 'dart:typed_data';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:network_image_to_byte/network_image_to_byte.dart';
import 'package:pointrestaurant/models/payment_load.dart';
import 'package:pointrestaurant/services/payment/load_total_pay.dart';
import 'package:pointrestaurant/services/table_model/print_sevices.dart';
import 'package:pointrestaurant/utilities/path.dart';
import 'package:pointrestaurant/utilities/style.main.dart';
import 'package:pointrestaurant/widget/center_loading_indecator.dart';
import 'package:image/image.dart' as Martin;
import '../../utilities/globals.dart' as globals;
import '../main_screen.dart';

class PaymentScreen extends StatefulWidget {
  final saleMasterId;
  const PaymentScreen({
    Key key,
    this.saleMasterId,
  }) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final f = new NumberFormat("#,##0.00");
  final formatToRiel = new NumberFormat("#,##0");
  bool _isLoading = false;
  Future<List<PaymentLoad>> paymentData;
  double khReturn = 0.0;
  double usReturn = 0.0;
  double totalPrice = 0.0;
  double totalwithAllCurrency = 0;
  int storeValInUS = 0;
  int storeValInKH = 0;
  bool isReturn = false;

// store rate and exchange date____________________________________
  int rateIdUS;
  int rateIdKh;
  int exChangeRateUS;
  int exChangeRateKh;
// store rate and exchange date____________________________________

// ++++++++++++++++++++++++++++++++++ Section Working with Network Printer ++++++++++++++++++++++++++++++++

  PrinterNetworkManager printerManager = PrinterNetworkManager();

  _printWithNetwork(data) async {
    for (int i = 1; i <= data.length; i++) {
      String path = '$serverIP/temp/$i.png';
      await networkImageToByte(path).then((bytes) {
        imgListBytes[i] = bytes;
        _connectPrinter(data[i - 1]['host'], i);
      });
    }
  }

  _connectPrinter(host, int index) async {
    printerManager.selectPrinter(
      host,
      port: 9100,
      timeout: Duration(milliseconds: 500),
    );
    PosPrintResult res =
        await printerManager.printTicket(await testTicket(index));
    if (res.value == 2 || res.value == 3 || res.value == 4) {
      validationDialog(message: 'Printer is not connected !');
      setState(() {
        _isLoading = false;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => MainScreenPage(),
        ),
      );
    }
  }

  Future<Ticket> testTicket(index) async {
    final profile = await CapabilityProfile.load();
    final Ticket ticket = Ticket(PaperSize.mm80, profile);
    var image = Martin.decodeImage(imgListBytes[index]);
    ticket.image(image);
    ticket.feed(2);
    ticket.cut();
    return ticket;
  }

// ++++++++++++++++++++++++++++++++++ Section Working with Network Printer ++++++++++++++++++++++++++++++++

  // ___________________________________ Section Work with M1 ______________________________________________
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  BluetoothDevice _device;
  Map<int, Uint8List> imgListBytes = Map();
  void _connect() {
    if (_device == null) {
      print('Device Not');
    } else {
      bluetooth.isConnected.then((isConnected) {
        if (!isConnected) {
          bluetooth.connect(_device).catchError((error) {
            print('throw errror from connect to bluetooth:' + error);
          });
        }
      });
    }
  }

  Future initPlatformState() async {
    List<BluetoothDevice> devices = [];
    try {
      devices = await bluetooth.getBondedDevices();
    } on PlatformException {}

    if (!mounted) return;
    setState(() {
      _device = devices[0];
      _connect();
    });
  }

  _convertNetworkImageToByte(int target) async {
    await initPlatformState();
    for (int i = 1; i <= target; i++) {
      String path = '$serverIP/temp/$i.png';
      await networkImageToByte(path).then((bytes) {
        imgListBytes[i] = bytes;
        if (i == target) {
          printWithM1withBytes(target);
        }
      });
    }
  }

  void printWithM1withBytes(int index) async {
    for (int index = 1; index <= imgListBytes.length; index++) {
      bluetooth.printImageBytes(imgListBytes[index]);
      if (imgListBytes.length == index) {
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.paperCut();
        bluetooth.disconnect();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => MainScreenPage(),
          ),
        );
      }
    }
  }

  // ___________________________________ Section Work with M1 ______________________________________________
  @override
  void initState() {
    super.initState();
    paymentData = fetchPaymentMethod(sale_master_id: widget.saleMasterId);
  }

  calculatePay() {
    totalwithAllCurrency = storeValInUS + (storeValInKH / 4100);

    if (totalPrice - totalwithAllCurrency > 0) {
      usReturn = totalPrice - totalwithAllCurrency;
      khReturn = usReturn * 4100;
      isReturn = false;
    } else {
      usReturn = totalwithAllCurrency - totalPrice;
      khReturn = usReturn * 4100;
      isReturn = true;
    }
    setState(() {});
  }

  final elements1 = [
    "ABA",
    "PI PAY",
    "WING",
    "TRUE MONEY",
    "ACLEDA",
  ];

  int selectedIndex1 = 0;

  BoxDecoration cardShadow = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(5),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        offset: Offset(0, 3),
        blurRadius: 20,
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double cardWidth =
        size.width >= 1000 ? size.width * 0.35 : size.width * 0.9;
    bool orientation =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      body: _isLoading
          ? CenterLoadingIndicator()
          : FutureBuilder(
              future: paymentData,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return CenterLoadingIndicator();
                }
                totalPrice = double.parse(snapshot.data[0].total.grandTotalUs);
                double rowWidth = 90;
                return Stack(
                  children: <Widget>[
                    _buildHeader(context),
                    Positioned.fill(
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top + 30.0,
                        ),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: MediaQuery.of(context).padding.top,
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: DefaultTabController(
                                  child: new LayoutBuilder(
                                    builder: (BuildContext context,
                                        BoxConstraints viewportConstraints) {
                                      return SingleChildScrollView(
                                        child: Column(
                                          children: <Widget>[
                                            // _______________________Total Header__________________
                                            Container(
                                              margin: EdgeInsets.only(
                                                bottom: 20,
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                vertical: 20,
                                                horizontal: 25,
                                              ),
                                              height: orientation
                                                  ? size.height * .3
                                                  : size.height * .3,
                                              width: cardWidth,
                                              decoration: cardShadow,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      Text(
                                                        '',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'San-francisco',
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors.black87,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: <Widget>[
                                                            Text(
                                                              'USD ( \$ )',
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'San-francisco',
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Container(
                                                              width: rowWidth,
                                                              child: Text(
                                                                'Riel ( ​៛ )',
                                                                textAlign:
                                                                    TextAlign
                                                                        .right,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'San-francisco',
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Divider(
                                                    color: Colors.black45,
                                                    height: 1.2,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Text(
                                                        'Total :',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'San-francisco',
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors.black87,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: <Widget>[
                                                            Text(
                                                              snapshot
                                                                  .data[0]
                                                                  .total
                                                                  .grandTotalUs,
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'San-francisco',
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Container(
                                                              width: 100,
                                                              child: Text(
                                                                formatToRiel
                                                                    .format(
                                                                  double.parse(
                                                                    snapshot
                                                                        .data[0]
                                                                        .total
                                                                        .grandTotalKh,
                                                                  ),
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .right,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'San-francisco',
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Text(
                                                        'Return :',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'San-francisco',
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors.black87,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: <Widget>[
                                                            Text(
                                                              isReturn
                                                                  ? f.format(
                                                                      usReturn)
                                                                  : "( " +
                                                                      f.format(
                                                                          usReturn) +
                                                                      " )",
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'San-francisco',
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Container(
                                                              width: rowWidth,
                                                              child: Text(
                                                                isReturn
                                                                    ? (formatToRiel
                                                                            .format((khReturn / 100).round() *
                                                                                100)
                                                                            .split('.')[
                                                                        0])
                                                                    : "( " +
                                                                        (formatToRiel
                                                                            .format((khReturn / 100).round() *
                                                                                100)
                                                                            .split('.')[0]) +
                                                                        " )",
                                                                textAlign:
                                                                    TextAlign
                                                                        .right,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'San-francisco',
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: cardWidth,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  width: 1.2,
                                                  color: Colors.grey[300],
                                                ),
                                              ),
                                              child: Column(
                                                children: <Widget>[
                                                  Container(
                                                    height: size.height * .4,
                                                    child: Column(
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: new TabBar(
                                                              tabs: [
                                                                Tab(
                                                                    text:
                                                                        "CASH"),
                                                                // Tab(
                                                                //     text:
                                                                //         "CREDIT / DEBIT CARD"),
                                                                // Tab(text: "MEMBER"),
                                                              ],
                                                              labelColor:
                                                                  Colors.white,
                                                              unselectedLabelColor:
                                                                  kPrimaryColor,
                                                              indicatorPadding:
                                                                  EdgeInsets.only(
                                                                      left: 30,
                                                                      right:
                                                                          30),
                                                              indicator:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            7),
                                                                color:
                                                                    kPrimaryColor,
                                                              )),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          10),
                                                              child: TabBarView(
                                                                  children: [
                                                                    _buildPayOnCash(
                                                                        size:
                                                                            size,
                                                                        textfieldWidth:
                                                                            size
                                                                                .width,
                                                                        data: snapshot
                                                                            .data[0]
                                                                            .currency),
                                                                    // _buildBankCard(
                                                                    //     size,
                                                                    //     size.width),
                                                                    // _buildMemberShip(
                                                                    //     size,
                                                                    //     orientation)
                                                                  ])),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 15,
                                                            horizontal: 20),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Material(
                                                        color:
                                                            Colors.transparent,
                                                        child: InkWell(
                                                          onTap: () {
                                                            isReturn
                                                                ? globals.pay ==
                                                                        1
                                                                    ? payInternalPrintESCPos(
                                                                        sale_master_id:
                                                                            widget.saleMasterId,
                                                                        rate_us_id:
                                                                            rateIdUS,
                                                                        rate_kh_id:
                                                                            rateIdKh,
                                                                        exchange_rate_kh:
                                                                            exChangeRateKh,
                                                                        exchange_rate_us:
                                                                            exChangeRateUS,
                                                                        amount_us:
                                                                            storeValInUS,
                                                                        amount_kh:
                                                                            storeValInKH,
                                                                        return_kh:
                                                                            khReturn.round(),
                                                                        return_us:
                                                                            usReturn,
                                                                      ).then(
                                                                        (value) {
                                                                        setState(
                                                                            () {
                                                                          _isLoading =
                                                                              true;
                                                                        });
                                                                        _printWithNetwork(
                                                                            value);
                                                                      })
                                                                    : payInternalPrint(
                                                                        sale_master_id:
                                                                            widget.saleMasterId,
                                                                        rate_us_id:
                                                                            rateIdUS,
                                                                        rate_kh_id:
                                                                            rateIdKh,
                                                                        exchange_rate_kh:
                                                                            exChangeRateKh,
                                                                        exchange_rate_us:
                                                                            exChangeRateUS,
                                                                        amount_us:
                                                                            storeValInUS,
                                                                        amount_kh:
                                                                            storeValInKH,
                                                                        return_kh:
                                                                            khReturn.round(),
                                                                        return_us:
                                                                            usReturn,
                                                                      ).then(
                                                                        (index) {
                                                                        setState(
                                                                            () {
                                                                          _isLoading =
                                                                              true;
                                                                        });
                                                                        imgListBytes
                                                                            .clear();
                                                                        _convertNetworkImageToByte(
                                                                            index);
                                                                      })
                                                                : Container();
                                                          },
                                                          splashColor:
                                                              kPrimaryColor
                                                                  .withOpacity(
                                                                      .5),
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            height: 55,
                                                            alignment: Alignment
                                                                .center,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              border: isReturn
                                                                  ? Border.all(
                                                                      color:
                                                                          kPrimaryColor,
                                                                      width:
                                                                          1.3,
                                                                    )
                                                                  : Border.all(
                                                                      color: Colors
                                                                              .grey[
                                                                          400],
                                                                      width:
                                                                          1.3,
                                                                    ),
                                                            ),
                                                            child: Text(
                                                              'PAY NOW',
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                color: isReturn
                                                                    ? kPrimaryColor
                                                                    : Colors.grey[
                                                                        400],
                                                                fontFamily:
                                                                    'San-francisco',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  length: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }

  _buildHeader(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                kPrimaryColor,
                Color(0xFFeb4438),
              ],
            ),
          ),
          height: MediaQuery.of(context).size.height * .45,
        ),
        AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            "Payment",
            style: TextStyle(
              fontFamily: 'San-francisco',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  _buildPayOnCash({Size size, double textfieldWidth, var data}) {
    rateIdUS = data[0].id;
    rateIdKh = data[1].id;
    exChangeRateUS = int.parse(data[0].rate);
    exChangeRateKh = int.parse(data[1].rate);
    return Container(
      width: double.infinity,
      height: size.height,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: textfieldWidth,
                  height: 50.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: TextFormField(
                      onChanged: (dollar) {
                        if (!(dollar.length > 0)) {
                          storeValInUS = 0;
                        } else {
                          storeValInUS = int.parse(dollar);
                        }
                        calculatePay();
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText:
                            data[0].currency + " ( " + data[0].sign + " )",
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
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: textfieldWidth,
                  height: 50.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: TextFormField(
                      onChanged: (riel) {
                        storeValInKH = int.parse(riel);
                        if (storeValInKH > 100) {
                          calculatePay();
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText:
                            data[1].currency + " ( " + data[1].sign + " )",
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
          )
        ],
      ),
    );
  }

  // _buildMemberShip(Size size, orientation) {
  //   return SingleChildScrollView(
  //     child: Container(
  //       padding:
  //           EdgeInsets.symmetric(vertical: 10, horizontal: size.width * .08),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Container(
  //             child: Image.asset(
  //               'assets/images/softpointcard.jpg',
  //               width: orientation == Orientation.landscape
  //                   ? size.width * .3
  //                   : size.width * .95,
  //             ),
  //           ),
  //           SizedBox(
  //             height: size.height * .04,
  //           ),
  //           Material(
  //             color: Colors.transparent,
  //             child: InkWell(
  //               onTap: () {
  //                 // _showDialog();
  //               },
  //               child: Container(
  //                 height: 45,
  //                 width: orientation == Orientation.landscape
  //                     ? size.width * .3
  //                     : size.width * .95,
  //                 alignment: Alignment.center,
  //                 child: Text(
  //                   'Scan Your Card',
  //                   style: TextStyle(
  //                     color: Colors.white,
  //                     fontFamily: 'San-francisco',
  //                     fontSize: 15,
  //                     fontWeight: FontWeight.w800,
  //                   ),
  //                 ),
  //                 decoration: new BoxDecoration(
  //                   color: kPrimaryColor,
  //                   borderRadius: new BorderRadius.circular(30.0),
  //                   boxShadow: [
  //                     BoxShadow(
  //                       offset: Offset(0, 5),
  //                       blurRadius: 20,
  //                       color: kPrimaryColor.withOpacity(.4),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // _buildBankCard(Size size, double textfieldWidth) {
  //   return SingleChildScrollView(
  //     child: Container(
  //       padding: EdgeInsets.symmetric(horizontal: size.width * .08),
  //       child: Column(
  //         children: <Widget>[
  //           Container(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: <Widget>[
  //                 Padding(
  //                   padding: EdgeInsets.only(left: 4),
  //                   child: Text(
  //                     'Card Type',
  //                     style: TextStyle(
  //                       fontFamily: "San-francisco",
  //                       color: Colors.black,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: 8.0,
  //                 ),
  //                 DirectSelect(
  //                   itemExtent: 35.0,
  //                   selectedIndex: selectedIndex1,
  //                   child: MySelectionItem(
  //                     isForList: false,
  //                     title: elements1[selectedIndex1],
  //                   ),
  //                   onSelectedItemChanged: (index) {
  //                     setState(() {
  //                       selectedIndex1 = index;
  //                     });
  //                   },
  //                   items: _buildItems1(),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Row(
  //             children: <Widget>[
  //               Expanded(
  //                 child: TextInputContainer(
  //                     textfieldWidth: textfieldWidth, title: 'Amount'),
  //               ),
  //               SizedBox(
  //                 width: size.width * .03,
  //               ),
  //               Expanded(
  //                 child: TextInputContainer(
  //                   textfieldWidth: textfieldWidth,
  //                   title: 'Discount',
  //                 ),
  //               ),
  //             ],
  //           ),
  //           TextInputContainer(
  //             textfieldWidth: textfieldWidth,
  //             title: 'Transaction Number',
  //           ),
  //           Row(
  //             children: <Widget>[
  //               Expanded(
  //                 child: TextInputContainer(
  //                     textfieldWidth: textfieldWidth, title: 'Account Name'),
  //               ),
  //               SizedBox(
  //                 width: size.width * .03,
  //               ),
  //               Expanded(
  //                 child: TextInputContainer(
  //                   textfieldWidth: textfieldWidth,
  //                   title: 'Account Number',
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  void validationDialog({String message}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: new Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "San-francisco",
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                "Cancel",
                style: TextStyle(
                  fontFamily: "San-francisco",
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
