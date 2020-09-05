import 'package:flutter/material.dart';

_requestNoItmesModel(context) {
  return showGeneralDialog(
    barrierColor: Colors.black.withOpacity(0.9),
    transitionDuration: Duration(milliseconds: 200),
    barrierDismissible: true,
    barrierLabel: '',
    context: context,
    pageBuilder: (context, animation1, animation2) {
      return null;
    },
    transitionBuilder: (context, a1, a2, widget) {
      var size = MediaQuery.of(context).size;
      return Transform.scale(
        scale: a1.value,
        child: Opacity(
          opacity: a1.value,
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              width: size.width * .5,
              height: size.height * .3,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Container(
                  child: Text('No Items Orders',
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'San-francisco',
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.none,
                      )),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
