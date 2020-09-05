import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'utilities/size.cofig.dart';
import 'widget/loading.slash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext constraints) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 450) {
          SystemChrome.setPreferredOrientations(
            [
              DeviceOrientation.portraitUp,
            ],
          );
        } else {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeLeft,
          ]);
        }
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: AppBarTheme(
                  color: Colors.white,
                ),
              ),
              home: LoadingPage(),
            );
          },
        );
      },
    );
  }
}
