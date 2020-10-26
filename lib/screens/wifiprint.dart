import 'dart:typed_data';

import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart';
import 'package:network_image_to_byte/network_image_to_byte.dart';

class WifiPrint extends StatefulWidget {
  @override
  _WifiPrintState createState() => _WifiPrintState();
}

PrinterNetworkManager printerManager = PrinterNetworkManager();
_connectPrinter() async {
  printerManager.selectPrinter('192.168.1.88', port: 9100);
  final PosPrintResult res =
      await printerManager.printTicket(await testTicket());
  print('Print result: ${res.msg}');
}

_convertNetworkImagetoBytes(path) async {
  if (path == null) {
    return;
  }
  await networkImageToByte(path).then((bytes) {
    return bytes;
  });
}

Future<Ticket> testTicket() async {
  final profile = await CapabilityProfile.load();
  final Ticket ticket = Ticket(PaperSize.mm80, profile);

  // Print image
  final ByteData data = await rootBundle.load('assets/images/imginvoice.jpg');
  final Uint8List bytes = data.buffer.asUint8List();
  var image = decodeImage(bytes);
  ticket.image(image);

  // Print image using alternative commands
  // ticket.imageRaster(image);

  ticket.feed(2);
  ticket.cut();
  return ticket;
}

class _WifiPrintState extends State<WifiPrint> {
  @override
  void initState() {
    _connectPrinter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        alignment: Alignment.center,
        color: Colors.grey,
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.print,
          ),
        ),
      ),
    );
  }
}
