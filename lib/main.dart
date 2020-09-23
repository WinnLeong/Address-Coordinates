import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'router.gr.dart';
import 'utils/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ScreenUtil.init(designSize: Size(750, 1334), allowFontScaling: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Addresss Coordinates',
      theme: ThemeData(
        primaryColor: ColorConstant.primaryColor,
        fontFamily: 'Myriad',
        textTheme: FontTheme().primaryFont,
        primaryTextTheme: FontTheme().primaryFont,
        accentTextTheme: FontTheme().primaryFont,
        // visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      builder: ExtendedNavigator<Router>(
        initialRoute: Routes.home,
        router: Router(),
      ),
    );
  }
}
