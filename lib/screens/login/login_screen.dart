import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../utilities/path.dart';
import '../main_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

bool showPassword = true;
String checkUser = '';
String checkPass = '';

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textfieldWidth =
        MediaQuery.of(context).orientation == Orientation.landscape
            ? size.width * 0.4
            : size.width * 0.8;
    var red = 0xffE50B2E;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "LOGIN",
          style: TextStyle(color: Colors.grey),
        ),
        leading: IconButton(
            icon: Icon(
              FontAwesomeIcons.chevronLeft,
              color: Colors.grey[700],
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                width: size.width,
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.only(top: size.height * 0.08),
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ClipRRect(
                      child: Image.asset(
                        appbarLogo,
                        width: 120,
                        height: 120,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Point Restaurant",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color(red),
                        fontFamily: "San-francisco",
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        width: textfieldWidth,
                        child: Text(
                          "Username",
                          style: TextStyle(
                              fontFamily: "San-francisco", color: Colors.black),
                        )),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      width: textfieldWidth,
                      height: 50.0,
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(red), width: 1.5),
                          borderRadius: BorderRadius.circular(40.0)),
                      child: Center(
                        child: TextField(
                            style: TextStyle(color: Colors.red),
                            onChanged: (val) {
                              setState(() {
                                checkUser = val;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter Usernam',
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 16.0),
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.grey,
                              ),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(bottom: 5),
                      width: textfieldWidth,
                      child: Text(
                        "Password",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Container(
                      width: textfieldWidth,
                      height: 50.0,
                      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 8),
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(red), width: 1.5),
                          borderRadius: BorderRadius.circular(40.0)),
                      child: Center(
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          onChanged: (val) {
                            setState(() {
                              checkPass = val;
                            });
                          },
                          obscureText: showPassword,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 3),
                            hintText: "Enter Password",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                            ),
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.lock, color: Colors.grey),
                            suffixIcon: IconButton(
                                icon: showPassword
                                    ? Icon(
                                        Icons.visibility_off,
                                        color: Color(red),
                                      )
                                    : Icon(
                                        Icons.visibility,
                                        color: Color(red),
                                      ),
                                onPressed: () {
                                  setState(() {
                                    showPassword = !showPassword;
                                  });
                                }),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 35.0,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(40.0),
                        color: Color(red),
                        child: InkWell(
                          splashColor: Colors.white24,
                          onTap: () {
                            Navigator.push(
                              context,
                              // ignore: missing_return
                              MaterialPageRoute(
                                builder: (_) => MainScreenPage(),
                              ),
                            );
                          },
                          child: Container(
                            width: textfieldWidth,
                            height: 50.0,
                            child: Center(
                              child: Text(
                                "LOGIN",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
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
    );
  }
}
