import 'package:flutter/material.dart';
import 'package:flutter_collapse/flutter_collapse.dart';
import 'package:pointrestaurant/models/list_sale_data.dart';
import 'package:pointrestaurant/screens/order/components/event_button.dart';
import 'package:pointrestaurant/services/invoice/ListSaleSummary.dart';
import 'package:pointrestaurant/utilities/style.main.dart';
import 'package:pointrestaurant/widget/center_loading_indecator.dart';
import 'package:pointrestaurant/widget/company_header.dart';

class InvocieScreeen extends StatefulWidget {
  @override
  _InvocieScreeenState createState() => _InvocieScreeenState();
}

class _InvocieScreeenState extends State<InvocieScreeen> {
  Future<List<ListSaleData>> listSaleData;

  List<bool> growableList = [];
  @override
  void initState() {
    super.initState();
    listSaleData = fetchlistSaleSummary();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        children: <Widget>[
          CampanyHeaderContianer(),
          Expanded(
            child: FutureBuilder(
              future: listSaleData,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
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
                          value: growableList[index],
                          onChange: (bool value) {
                            for (int i = 0; i < growableList.length; i++) {
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
                              vertical: 25,
                              horizontal: 30,
                            ),
                            height: 230,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[50],
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 3),
                                  color: Color(0xffdbdbdb),
                                  blurRadius: 20,
                                )
                              ],
                            ),
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
                                        snapshot.data[index].discountInvDollars,
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
                                            ? '0'
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
                                        snapshot.data[index].totalDisItem
                                                    .toString() ==
                                                ''
                                            ? '0'
                                            : snapshot.data[index].totalDisItem
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
                                  height: 20,
                                ),
                                Divider(
                                  height: 1.2,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                        color: kPrimaryColor,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Center(
                                      child: Icon(
                                        Icons.print,
                                        color: Colors.white,
                                      ),
                                    )),
                              ],
                            ),
                          ));
                    },
                  );
                }
                return Container(
                  child: Center(
                    child: Text('NO DATA'),
                  ),
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}
