import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pointrestaurant/models/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utilities/path.dart';
import '../../utilities/style.main.dart';
import '../main_screen.dart';
import '../payment/components/content_card.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPassword = true;
  String checkUser = '';
  String checkPass = '';
  loadSharePreferenc(String userLog) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userLog', userLog);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textfieldWidth =
        MediaQuery.of(context).orientation == Orientation.landscape
            ? size.width * 0.4
            : size.width * 0.8;
    var red = 0xffE50B2E;
    // return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: Colors.white,
    //     elevation: 0.0,
    //     centerTitle: true,
    //     leading: IconButton(
    //         icon: Icon(
    //           FontAwesomeIcons.chevronLeft,
    //           color: Colors.black87,
    //           size: 16,
    //         ),
    //         onPressed: () {
    //           Navigator.pop(context);
    //         }),
    //     iconTheme: IconThemeData(
    //       color: Colors.black,
    //     ),
    //   ),
    //   body: SafeArea(
    //     child: SingleChildScrollView(
    //       child: Stack(
    //         children: <Widget>[
    //           Container(
    //             width: size.width,
    //             height: MediaQuery.of(context).size.height,
    //             margin: EdgeInsets.only(top: size.height * 0.08),
    //             padding: EdgeInsets.only(top: 20, left: 20, right: 20),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: <Widget>[
    //                 ClipRRect(
    //                   child: Image.asset(
    //                     appbarLogo,
    //                     width: 120,
    //                     height: 120,
    //                   ),
    //                   borderRadius: BorderRadius.circular(10.0),
    //                 ),
    //                 SizedBox(
    //                   height: 15,
    //                 ),
    //                 Text(
    //                   "LOGIN",
    //                   style: TextStyle(
    //                     fontSize: 24,
    //                     fontWeight: FontWeight.w600,
    //                     color: Color(red),
    //                     fontFamily: "San-francisco",
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: 20.0,
    //                 ),
    //                 Container(
    //                     alignment: Alignment.centerLeft,
    //                     width: textfieldWidth,
    //                     child: Text(
    //                       "Username",
    //                       style: TextStyle(
    //                           fontFamily: "San-francisco", color: Colors.black),
    //                     )),
    //                 SizedBox(
    //                   height: 5.0,
    //                 ),
    //                 Container(
    //                   width: textfieldWidth,
    //                   height: 50.0,
    //                   padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
    //                   decoration: BoxDecoration(
    //                       border: Border.all(color: Color(red), width: 1.5),
    //                       borderRadius: BorderRadius.circular(40.0)),
    //                   child: Center(
    //                     child: TextField(
    //                         style: TextStyle(color: Colors.red),
    //                         onChanged: (val) {
    //                           setState(() {
    //                             checkUser = val;
    //                           });
    //                         },
    //                         decoration: InputDecoration(
    //                           hintText: 'Enter Usernam',
    //                           hintStyle:
    //                               TextStyle(color: Colors.grey, fontSize: 16.0),
    //                           border: InputBorder.none,
    //                           prefixIcon: Icon(
    //                             Icons.email,
    //                             color: Colors.grey,
    //                           ),
    //                         )),
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: 20.0,
    //                 ),
    //                 Container(
    //                   alignment: Alignment.centerLeft,
    //                   margin: EdgeInsets.only(bottom: 5),
    //                   width: textfieldWidth,
    //                   child: Text(
    //                     "Password",
    //                     style: TextStyle(color: Colors.black),
    //                   ),
    //                 ),
    //                 Container(
    //                   width: textfieldWidth,
    //                   height: 50.0,
    //                   padding: EdgeInsets.symmetric(vertical: 7, horizontal: 8),
    //                   decoration: BoxDecoration(
    //                       border: Border.all(color: Color(red), width: 1.5),
    //                       borderRadius: BorderRadius.circular(40.0)),
    //                   child: Center(
    //                     child: TextField(
    //                       style: TextStyle(color: Colors.grey),
    //                       onChanged: (val) {
    //                         setState(() {
    //                           checkPass = val;
    //                         });
    //                       },
    //                       obscureText: showPassword,
    //                       decoration: InputDecoration(
    //                         contentPadding: EdgeInsets.only(bottom: 3),
    //                         hintText: "Enter Password",
    //                         hintStyle: TextStyle(
    //                           color: Colors.grey,
    //                           fontSize: 16.0,
    //                         ),
    //                         border: InputBorder.none,
    //                         prefixIcon: Icon(Icons.lock, color: Colors.grey),
    //                         suffixIcon: IconButton(
    //                             icon: showPassword
    //                                 ? Icon(
    //                                     Icons.visibility_off,
    //                                     color: Color(red),
    //                                   )
    //                                 : Icon(
    //                                     Icons.visibility,
    //                                     color: Color(red),
    //                                   ),
    //                             onPressed: () {
    //                               setState(() {
    //                                 showPassword = !showPassword;
    //                               });
    //                             }),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: 35.0,
    //                 ),
    //                 ClipRRect(
    //                   borderRadius: BorderRadius.circular(40.0),
    //                   child: Material(
    //                     borderRadius: BorderRadius.circular(40.0),
    //                     color: Color(red),
    //                     child: InkWell(
    //                       splashColor: Colors.white24,
    //                       onTap: () {
    //                         if (checkPass != null &&
    //                             checkUser != null &&
    //                             checkUser.trim() != '' &&
    //                             checkPass.trim() != '') {
    //                           logInSubmit(checkUser, checkPass).then(
    //                             (value) {
    //                               if (value == 'Username' ||
    //                                   value == 'Password') {
    //                                 validationDialog(value);
    //                                 print('object');
    //                               } else {
    //                                 loadSharePreferenc(value);
    //                                 Navigator.pushReplacement(
    //                                   context,
    //                                   MaterialPageRoute(
    //                                     builder: (_) => MainScreenPage(
    //                                       userToken: value,
    //                                     ),
    //                                   ),
    //                                 );
    //                               }
    //                             },
    //                           );
    //                         } else if (checkUser.trim() == '' ||
    //                             checkPass.trim() == '') {
    //                           validateTextfield();
    //                         } else {
    //                           print('no data');
    //                           return;
    //                         }
    //                       },
    //                       child: Container(
    //                         width: textfieldWidth,
    //                         height: 50.0,
    //                         child: Center(
    //                           child: Text(
    //                             "LOGIN",
    //                             style: TextStyle(
    //                               color: Colors.white,
    //                               fontWeight: FontWeight.w700,
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Image.asset(
                  'assets/images/background.png',
                  width: size.width,
                  height: size.height,
                  fit: BoxFit.cover,
                ),
                // Container(
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.only(
                //       bottomLeft: Radius.circular(10),
                //       bottomRight: Radius.circular(10),
                //     ),
                //     gradient: LinearGradient(
                //       begin: Alignment.topCenter,
                //       end: Alignment.bottomCenter,
                //       colors: [
                //         kPrimaryColor,
                //         Color(0xFFeb4438),
                //       ],
                //     ),
                //   ),
                //   height: MediaQuery.of(context).size.height * .45,
                // ),
                Positioned(
                  top: size.height * 0.4,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0)),
                      color: Colors.white,
                    ),
                    height: size.height * 0.6,
                    width: size.width,
                  ),
                ),
                // AppBar(
                //   leading: Icon(
                //     Icons.arrow_back_ios,
                //     color: kPrimaryColor,
                //   ),
                //   backgroundColor: Colors.transparent,
                //   elevation: 0.0,
                //   centerTitle: true,
                //   title: Text(
                //     "Payment",
                //     style: TextStyle(
                //       fontFamily: 'NothingYouCouldDo',
                //       fontWeight: FontWeight.bold,
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
              ],
            ),
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 20.0,
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).padding.top,
                    ),
                    Expanded(
                      // child: ContentCard(),
                      child: Container(),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.21,
              left: size.width * 0.05,
              child: Container(
                height: size.height * 0.6,
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 40.0),
                      child: Text(
                        'SIGN IN',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 60.0),
                      width: textfieldWidth,
                      height: 50.0,
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                      decoration: BoxDecoration(
                          // border: Border.all(color: Color(red), width: 1.5),
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Center(
                        child: TextField(
                          style: TextStyle(color: Colors.red),
                          onChanged: (val) {
                            setState(
                              () {
                                checkUser = val;
                              },
                            );
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter Usernam',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 16.0),
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      width: textfieldWidth,
                      height: 50.0,
                      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 8),
                      decoration: BoxDecoration(
                          // border: Border.all(color: Color(red), width: 1.5),
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey[200]),
                      child: Center(
                        child: TextField(
                          style: TextStyle(color: Colors.grey),
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
                                setState(
                                  () {
                                    showPassword = !showPassword;
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color(red),
                        child: InkWell(
                          splashColor: Colors.white24,
                          onTap: () {
                            print('object');
                            if (checkPass != null &&
                                checkUser != null &&
                                checkUser.trim() != '' &&
                                checkPass.trim() != '') {
                              logInSubmit(checkUser, checkPass).then(
                                (value) {
                                  if (value == 'Username' ||
                                      value == 'Password') {
                                    validationDialog(value);
                                    print('object');
                                  } else {
                                    loadSharePreferenc(value);
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => MainScreenPage(
                                          userToken: value,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              );
                            } else if (checkUser.trim() == '' ||
                                checkPass.trim() == '') {
                              validateTextfield();
                            } else {
                              print('no data');
                              return;
                            }
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
            ),
          ],
        ),
      ),
    );
  }

  void validationDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: new Text(
            "Please Enter the Correct " + message,
            style: TextStyle(fontFamily: "San-francisco"),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                "Cancel",
                style: TextStyle(
                    fontFamily: "San-francisco", fontWeight: FontWeight.bold),
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

  void validateTextfield() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: new Text(
            "Error Username or Password ",
            style: TextStyle(fontFamily: "San-francisco"),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                "Cancel",
                style: TextStyle(
                    fontFamily: "San-francisco", fontWeight: FontWeight.bold),
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
