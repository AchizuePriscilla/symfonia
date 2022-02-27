import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:symfonia_task/presentation/shared/palette.dart';
import 'package:symfonia_task/presentation/views/history_view.dart';

import 'utils/app_utils/locator.dart';

void main() async {
  await setupLocator(baseApi: "https://api.coingecko.com/api/v3/coins/");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            textTheme: GoogleFonts.robotoTextTheme(),
            scaffoldBackgroundColor: Palette.offWhite),
        builder: (context, widget) => ScreenUtilInit(
              designSize: const Size(360, 630),
              builder: () => const HistoryView(),
            ));
  }
}
