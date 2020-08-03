import 'package:direct_select/direct_select.dart';
import 'package:flutter/material.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;
import 'package:pointrestaurant/utilities/style.main.dart';

import 'select_bank_card.dart';
import 'text_input_container.dart';

class ContentCard extends StatefulWidget {
  @override
  _ContentCardState createState() => _ContentCardState();
}

class _ContentCardState extends State<ContentCard> {
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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: DefaultTabController(
        child: new LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 20, right: 15, left: 15),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                  height: orientation ? size.height * .23 : size.height * .23,
                  width: orientation ? size.width * .5 : size.width * .95,
                  decoration: cardShadow,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildTitleRow('Grand Total', 110),
                      _buildTitleRow('Total Pay', 150),
                      _buildTitleRow('Return ', 40),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: orientation ? size.width * .8 : size.width * .95,
                    decoration: cardShadow,
                    child: Column(
                      children: <Widget>[
                        _buildTabBar(),
                        _buildContentContainer(viewportConstraints),
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
    );
  }

  _showDialog() {
    slideDialog.showSlideDialog(
      context: context,
      child: Text("Hello World"),
      barrierColor: Colors.black38.withOpacity(.8),
      pillColor: Colors.red,
      backgroundColor: Colors.white,
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
    return Expanded(
      flex: 1,
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: _buildMulticityTab()),
    );
  }

  _buildMulticityTab() {
    var size = MediaQuery.of(context).size;
    var orientation = MediaQuery.of(context).orientation;
    var textfieldWidth = size.width;
    return TabBarView(children: [
      _buildPayOnCash(size, textfieldWidth),
      _buildBankCard(size, textfieldWidth),
      _buildMemberShip(size, orientation)
    ]);
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
                  _showDialog();
                },
                child: Container(
                  alignment: Alignment.center,
                  height: orientation == Orientation.landscape
                      ? size.width * .3
                      : 47,
                  width: orientation == Orientation.landscape
                      ? size.width * .3
                      : size.width * .9,
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
