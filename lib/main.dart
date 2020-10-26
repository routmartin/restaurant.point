import 'package:flutter/material.dart';
import 'package:pointrestaurant/screens/wifiprint.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(new MyApp());
}
// void main() => runApp(
//       DevicePreview(
//         // enabled: !kReleaseMode,
//         builder: (context) => MyApp(),
//       ),
//     );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext constraints) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // if (constraints.maxWidth < 450) {
        //   SystemChrome.setPreferredOrientations(
        //     [
        //       DeviceOrientation.portraitUp,
        //     ],
        //   );
        // } else {
        //   SystemChrome.setPreferredOrientations([
        //     DeviceOrientation.landscapeLeft,
        //     DeviceOrientation.landscapeLeft,
        //   ]);
        // }
        return OrientationBuilder(
          builder: (context, orientation) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: AppBarTheme(
                  color: Colors.white,
                ),
              ),
              home: WifiPrint(),
            );
          },
        );
      },
    );
  }
}
