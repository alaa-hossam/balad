import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_router.dart';
import 'constants/strings.dart';

class BaladApp extends StatelessWidget {
  final AppRouter appRouter;

  const BaladApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        title: 'Balad App',
        debugShowCheckedModeBanner: false,
        initialRoute: homeScreen,
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}
