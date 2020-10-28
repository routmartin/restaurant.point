import 'package:flutter/material.dart';
import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:image/image.dart';
import 'package:network_image_to_byte/network_image_to_byte.dart';
import 'package:pointrestaurant/services/table_model/print_sevices.dart';
import '../utilities/globals.dart' as globals;

class NetworkPrinting extends StatefulWidget {
  @override
  _NetworkPrintingState createState() => _NetworkPrintingState();
}

String serverIP = 'http://${globals.ipAddress}:${globals.port}';
var imgBytesMartin;
PrinterNetworkManager printerManager = PrinterNetworkManager();
_connectPrinter() async {
  printerManager.selectPrinter('192.168.1.88', port: 9100);
  final PosPrintResult res =
      await printerManager.printTicket(await testTicket());
  print('Print result: ${res.msg}');
}

_printWithNetwork(data) async {
  print(data);
  String path = '$serverIP/temp/1.png';
  await networkImageToByte(path).then((bytes) {
    imgBytesMartin = bytes;
  }).then((_) => _connectPrinter());
}

Future<Ticket> testTicket() async {
  final profile = await CapabilityProfile.load();
  final Ticket ticket = Ticket(PaperSize.mm80, profile);
  var image = decodeImage(imgBytesMartin);
  ticket.imageRaster(image);

  ticket.feed(2);
  ticket.cut();
  return ticket;
}

class _NetworkPrintingState extends State<NetworkPrinting> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        alignment: Alignment.center,
        color: Colors.white,
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: IconButton(
          onPressed: () {
            // printBillESC(sale_master_id: 46).then(
            //   (_) => _convertNetworkImagetoBytes(),
            // );

            printtoKitchenESC(sale_master_id: 4, table_name: 'តុលេខ 4').then(
              (data) => _printWithNetwork(data),
            );
          },
          icon: Icon(
            Icons.print,
          ),
        ),
      ),
    );
  }
}
