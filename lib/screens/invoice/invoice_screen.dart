import 'dart:typed_data';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_collapse/flutter_collapse.dart';
import 'package:network_image_to_byte/network_image_to_byte.dart';

import 'package:pointrestaurant/models/list_sale_data.dart';

import 'package:pointrestaurant/services/invoice/ListSaleSummary.dart';
import 'package:pointrestaurant/services/table_model/print_sevices.dart';
import 'package:pointrestaurant/utilities/style.main.dart';
import 'package:pointrestaurant/widget/center_loading_indecator.dart';
import 'package:pointrestaurant/utilities/path.dart';
import '../../utilities/globals.dart' as globals;
import 'package:image/image.dart' as Martin;

class InvocieScreeen extends StatefulWidget {
  @override
  _InvocieScreeenState createState() => _InvocieScreeenState();
}

class _InvocieScreeenState extends State<InvocieScreeen> {
  Future<List<ListSaleData>> listSaleData;
  List<bool> growableList = [];
  bool isLoading = false;
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
    return true;
  }

  _connectPrinter(host, int index) async {
    printerManager.selectPrinter(host,
        port: 9100, timeout: Duration(milliseconds: 800));
    final PosPrintResult res =
        await printerManager.printTicket(await testTicket(index));
    if (res.value == 2 || res.value == 3 || res.value == 4)
      validationDialog(message: 'Printer is not connected !');
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
        Navigator.pop(context);
      }
    }
  }

  printingLoadingIndicator() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          content: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
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

// ___________________________________ Section Work with M1 ______________________________________________

  @override
  void initState() {
    super.initState();
    listSaleData = fetchlistSaleSummary();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: baseBackgroundColor,
      body: isLoading
          ? Container(
              width: double.infinity,
              height: size.height,
              color: Colors.white,
              child: Center(
                child: CenterLoadingIndicator(),
              ),
            )
          : Container(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  size.width < 360
                      ? SizedBox(
                          height: 20,
                        )
                      : size.width >= 1000
                          ? SizedBox(
                              height: 25,
                            )
                          : SizedBox(
                              height: 1,
                            ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      color: Colors.white,
                      width: size.width >= 1200
                          ? size.width * 0.3
                          : size.width >= 1000 ? size.width * 0.4 : null,
                      child: FutureBuilder(
                        future: listSaleData,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CenterLoadingIndicator();
                          }
                          if (snapshot.data != null) {
                            if (growableList.length == 0) {
                              growableList.clear();
                              for (int i = 0; i < snapshot.data.length; i++) {
                                growableList.add(false);
                              }
                            }
                            return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return Collapse(
                                  padding: EdgeInsets.only(
                                    top: 1,
                                    left: 10,
                                    right: 10,
                                  ),
                                  value: growableList[index],
                                  onChange: (bool value) {
                                    for (int i = 0;
                                        i < growableList.length;
                                        i++) {
                                      growableList[i] = false;
                                    }
                                    growableList[index] = value;
                                    setState(() {});
                                  },
                                  title: Text(
                                    'Invoice #' + snapshot.data[index].invoice,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'San-francisco',
                                    ),
                                  ),
                                  body: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 15),
                                    decoration: cardDecoration,
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              'GRAND TOTAL',
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'San-francisco',
                                              ),
                                            ),
                                            Expanded(
                                                child: Text(
                                              snapshot.data[index].grandTotal,
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'San-francisco',
                                              ),
                                            )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              'DISCOUNT (\$)',
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'San-francisco',
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                snapshot.data[index]
                                                    .discountInvDollars,
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'San-francisco',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              'DISCOUNT (\%)',
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'San-francisco',
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                snapshot.data[index]
                                                            .discountInvPercentage ==
                                                        ''
                                                    ? '0.00'
                                                    : snapshot.data[index]
                                                        .discountInvPercentage,
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'San-francisco',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              'DISCOUNT IN ITEMS (\$)',
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'San-francisco',
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                snapshot.data[index]
                                                            .totalDisItem
                                                            .toString() ==
                                                        ''
                                                    ? '0.00'
                                                    : snapshot.data[index]
                                                        .totalDisItem
                                                        .toString(),
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'San-francisco',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              'SUBTOTAL',
                                              style: TextStyle(
                                                color: kPrimaryColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'San-francisco',
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                snapshot.data[index].subTotal,
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'San-francisco',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Divider(
                                          height: 1.2,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              'PAY (\$)',
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'San-francisco',
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                snapshot.data[index].payUs
                                                    .toString(),
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'San-francisco',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              'PAY (៛)',
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'San-francisco',
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                snapshot.data[index].payKh
                                                    .toString(),
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'San-francisco',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          height: 1.2,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              'RETURN (\$)',
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'San-francisco',
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                snapshot.data[index].returnUS,
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'San-francisco',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              'RETURN (៛)',
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'San-francisco',
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                snapshot.data[index].returnKh,
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'San-francisco',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: Material(
                                            color: kPrimaryColor,
                                            child: InkWell(
                                              splashColor: Colors.black87,
                                              onTap: () {
                                                globals.reprint == 1
                                                    ? reprintPrintInvoiceInternalESCPos(
                                                        saleMasterId: snapshot
                                                            .data[index].id,
                                                      ).then((value) {
                                                        setState(() {
                                                          isLoading = true;
                                                        });
                                                        _printWithNetwork(value)
                                                            .then((check) {
                                                          setState(() {
                                                            isLoading = false;
                                                          });
                                                        });
                                                      })
                                                    : reprintInvoiceWithM1(
                                                        saleMasterId: snapshot
                                                            .data[index].id,
                                                      ).then((index) {
                                                        imgListBytes.clear();
                                                        printingLoadingIndicator();
                                                        _convertNetworkImageToByte(
                                                            index);
                                                      });
                                              },
                                              child: Container(
                                                height: 40.0,
                                                child: Center(
                                                  child: Icon(
                                                    Icons.print,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                          return Container(
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset('assets/images/empty.png'),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'NO INVIOCES FOUND',
                                    style: textStyle,
                                  ),
                                ],
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
    );
  }

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
