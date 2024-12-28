import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:fursan_hris/pages/pages.dart';
import 'package:fursan_hris/services/services.dart';
import 'package:fursan_hris/shared/shared.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supercharged/supercharged.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


Future<void> main() async {
  /// Initialization time zones
  tz.initializeTimeZones();
  var jakarta = tz.getLocation('Asia/Jakarta');
  tz.setLocalLocation(jakarta);

  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static String dataName = '';
  static String dataAge = '';


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final scaffoldState = GlobalKey<ScaffoldState>();

  final controllerTopic = TextEditingController();

  bool isSubscribed = false;

  String token = '';

  Widget page = SplashPage();

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: page);
  }
}
