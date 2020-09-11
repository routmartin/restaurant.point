import 'package:flutter/material.dart';
import 'package:flutter_collapse/flutter_collapse.dart';
import 'package:pointrestaurant/models/List_sale_ummary.dart';
import 'package:pointrestaurant/services/invoice/ListSaleSummary.dart';

class InvocieScreeen extends StatefulWidget {
  @override
  _InvocieScreeenState createState() => _InvocieScreeenState();
}

class _InvocieScreeenState extends State<InvocieScreeen> {
  Future<List<ListSaleSummary>> listSaleSummary;

  @override
  void initState() {
    super.initState();
    listSaleSummary = fetchlistSaleSummary();
  }

  bool status1 = true;
  bool status2 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 100),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Collapse(
                value: status1,
                onChange: (bool value) {
                  setState(() {
                    status1 = value;
                  });
                },
                title: Text('Invoice'),
                body: Container(
                  width: double.infinity,
                  height: 400,
                  color: Colors.grey[200],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
