import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widget/loading.slash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext constraints) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // print(constraints.maxWidth);
        // if (constraints.maxWidth < 450) {
        //   SystemChrome.setPreferredOrientations([
        //     DeviceOrientation.portraitUp,
        //   ]);
        // } else {
        //   print('work');
        //   SystemChrome.setPreferredOrientations([
        //     DeviceOrientation.landscapeLeft,
        //     DeviceOrientation.landscapeLeft,
        //   ]);
        // }
        return OrientationBuilder(
          builder: (context, orientation) {
            // SizeConfig().init(constraints, orientation);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primaryColor: Color(0xfff0f0f0),
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
