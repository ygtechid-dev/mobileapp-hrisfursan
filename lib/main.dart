import 'dart:async';
import 'dart:io';

import 'package:face_camera/face_camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:workwise/pages/pages.dart';
import 'package:workwise/services/services.dart';
import 'package:workwise/shared/shared.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supercharged/supercharged.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'cubits/user/user_cubit.dart';


Future<void> main() async {
  /// Initialization time zones
  tz.initializeTimeZones();
  var jakarta = tz.getLocation('Asia/Jakarta');
  tz.setLocalLocation(jakarta);


  WidgetsFlutterBinding.ensureInitialized();

  await FaceCamera.initialize(); //Add this

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

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => UserCubit()),
        ],
        child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            home: page)
    );
  }
}
