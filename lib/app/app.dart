import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../presentation/resources/routes_manager.dart';

class MyApp extends StatefulWidget {
  // default constructor
  const MyApp._internal(); // Private named constructor

  static const MyApp instance =
      MyApp._internal(); // Single instance -- Singleton

  factory MyApp() => instance; //factory for the class instance

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: RoutesManager.routes,
      initialRoute: RoutesManager.loginRoute,
    );
  }
}
