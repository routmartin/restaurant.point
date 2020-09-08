import 'package:direct_select/direct_select.dart';
import 'package:flutter/material.dart';
import 'package:pointrestaurant/models/load_total_pay.dart';
import 'package:pointrestaurant/services/payment/load_total_pay.dart';
import 'package:pointrestaurant/utilities/style.main.dart';

import 'components/select_bank_card.dart';
import 'components/text_input_container.dart';

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
  var grandTotal;
  @override
  void initState() {
    super.initState();
  }

  final elements1 = [
    "ABA",
    "PI PAY",
    "WING",
    "TRUE MONEY",
    "ACLEDA",
  ];
  int selectedIndex1 = 0;

  List<Widget> _buildItems1() {
    return elements1
        .map(
          (val) => MySelectionItem(
            title: val,
          ),
        )
        .toList();
  }

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
    var size = MediaQuery.of(context).size;
    var orientation =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Stack(
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
                    fontFamily: 'NothingYouCouldDo',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 20.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).padding.top,
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 15),
                      child: DefaultTabController(
                        child: new LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints viewportConstraints) {
                            return Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      bottom: 20, right: 15, left: 15),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 25),
                                  height: orientation
                                      ? size.height * .23
                                      : size.height * .23,
                                  width: orientation
                                      ? size.width * .5
                                      : size.width * .95,
                                  decoration: cardShadow,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      _buildTitleRow('Grand Total', 110),
                                      _buildTitleRow('Total Pay', 150),
                                      _buildTitleRow('Return ', 40),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    width: orientation
                                        ? size.width * .8
                                        : size.width * .95,
                                    decoration: cardShadow,
                                    child: Column(
                                      children: <Widget>[
                                        _buildTabBar(),
                                        _buildContentContainer(
                                            viewportConstraints),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        length: 3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildTitleRow(String title, double val) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontFamily: 'San-francisco',
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        Expanded(
          child: Text(
            '\$ 100.00',
            // '\$'+val.roundToDouble().toString()
            textAlign: TextAlign.right,
            style: TextStyle(
              fontFamily: 'San-francisco',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  _buildTabBar({bool showFirstOption}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new TabBar(
          tabs: [
            Tab(text: "CASH"),
            Tab(text: "CREDIT / DEBIT CARD"),
            Tab(text: "MEMBEM"),
          ],
          labelColor: Colors.white,
          unselectedLabelColor: kPrimaryColor,
          indicatorPadding: EdgeInsets.only(left: 30, right: 30),
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: kPrimaryColor,
          )),
    );
  }

  _buildContentContainer(BoxConstraints viewportConstraints) {
    var size = MediaQuery.of(context).size;
    var orientation = MediaQuery.of(context).orientation;
    var textfieldWidth = size.width;
    return Expanded(
      flex: 1,
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: TabBarView(children: [
            _buildPayOnCash(size, textfieldWidth),
            _buildBankCard(size, textfieldWidth),
            _buildMemberShip(size, orientation)
          ])),
    );
  }

  _buildMemberShip(Size size, orientation) {
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.symmetric(vertical: 10, horizontal: size.width * .08),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset(
                'assets/images/softpointcard.jpg',
                width: orientation == Orientation.landscape
                    ? size.width * .3
                    : size.width * .95,
              ),
            ),
            SizedBox(
              height: size.height * .04,
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  // _showDialog();
                },
                child: Container(
                  height: 45,
                  width: orientation == Orientation.landscape
                      ? size.width * .3
                      : size.width * .95,
                  alignment: Alignment.center,
                  child: Text(
                    'Scan Your Card',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'San-francisco',
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  decoration: new BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: new BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 5),
                        blurRadius: 20,
                        color: kPrimaryColor.withOpacity(.4),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildBankCard(Size size, double textfieldWidth) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * .08),
        child: Column(
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 4),
                    child: Text(
                      'Card Type',
                      style: TextStyle(
                        fontFamily: "San-francisco",
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  DirectSelect(
                    itemExtent: 35.0,
                    selectedIndex: selectedIndex1,
                    child: MySelectionItem(
                      isForList: false,
                      title: elements1[selectedIndex1],
                    ),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedIndex1 = index;
                      });
                    },
                    items: _buildItems1(),
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextInputContainer(
                      textfieldWidth: textfieldWidth, title: 'Amount'),
                ),
                SizedBox(
                  width: size.width * .03,
                ),
                Expanded(
                  child: TextInputContainer(
                    textfieldWidth: textfieldWidth,
                    title: 'Discount',
                  ),
                ),
              ],
            ),
            TextInputContainer(
              textfieldWidth: textfieldWidth,
              title: 'Transaction Number',
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextInputContainer(
                      textfieldWidth: textfieldWidth, title: 'Account Name'),
                ),
                SizedBox(
                  width: size.width * .03,
                ),
                Expanded(
                  child: TextInputContainer(
                    textfieldWidth: textfieldWidth,
                    title: 'Account Number',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildPayOnCash(Size size, double textfieldWidth) {
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.symmetric(vertical: 10, horizontal: size.width * .08),
        child: Column(children: <Widget>[
          TextInputContainer(
            textfieldWidth: textfieldWidth,
          ),
          TextInputContainer(
            textfieldWidth: textfieldWidth,
            title: 'USD',
          ),
          TextInputContainer(
            textfieldWidth: textfieldWidth,
            title: 'THB',
          ),
        ]),
      ),
    );
  }
}
