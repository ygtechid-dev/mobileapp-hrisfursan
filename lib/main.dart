import 'dart:async';
import 'dart:io';

import 'package:face_camera/face_camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:workwise/cubits/payslip/payslip_cubit.dart';
import 'package:workwise/cubits/reimbursement/reimbursement_cubit.dart';
import 'package:workwise/pages/pages.dart';
import 'package:workwise/services/services.dart';
import 'package:workwise/shared/shared.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supercharged/supercharged.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:workwise/utils/app_local.dart';
import 'package:workwise/utils/cache_helper.dart';
import 'package:flutter_localizations/src/material_localizations.dart';
import 'package:flutter_localizations/src/widgets_localizations.dart';
import 'package:flutter_localizations/src/cupertino_localizations.dart';

import 'cubits/attendance/detail/attendance_detail_cubit.dart';
import 'cubits/attendance/history/attendance_history_cubit.dart';
import 'cubits/attendance/salary/salary_cubit.dart';
import 'cubits/attendance/working/working_period_cubit.dart';
import 'cubits/designation/designation_cubit.dart';
import 'cubits/event/events_cubit.dart';
import 'cubits/language/language_cubit.dart';
import 'cubits/language/language_state.dart';
import 'cubits/leaves/leaves_cubit.dart';
import 'cubits/leaves/remaining/leaves_remaining_cubit.dart';
import 'cubits/leaves/types/leaves_types_cubit.dart';
import 'cubits/notifications/notifications_cubit.dart';
import 'cubits/overtimes/overtimes_cubit.dart';
import 'cubits/payslip/detail/payslip_detail_cubit.dart';
import 'cubits/reimbursement/category/reimbursement_category_cubit.dart';
import 'cubits/task/assignee/assignee_cubit.dart';
import 'cubits/task/detail/task_detail_cubit.dart';
import 'cubits/task/task_cubit.dart';
import 'cubits/user/office_assets/office_assets_cubit.dart';
import 'cubits/user/user_cubit.dart';


Future<void> main() async {
  /// Initialization time zones
  tz.initializeTimeZones();
  var jakarta = tz.getLocation('Asia/Jakarta');
  tz.setLocalLocation(jakarta);

  WidgetsFlutterBinding.ensureInitialized();
  await FlutterLocalization.instance.ensureInitialized();
  await CacheHelper.init();

  await FaceCamera.initialize(); //Add this

  await FlutterDownloader.initialize(
      debug: true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl: true // option: set to false to disable working with http links (default: false)
  );

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

  final FlutterLocalization localization = FlutterLocalization.instance;

  @override
  void initState() {



    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => DesignationCubit()),
          BlocProvider(create: (_) => LeavesCubit()),
          BlocProvider(create: (_) => LeavesRemainingCubit()),
          BlocProvider(create: (_) => LeavesTypesCubit()),
          BlocProvider(create: (_) => OvertimesCubit()),
          BlocProvider(create: (_) => UserCubit()),
          BlocProvider(create: (_) => AttendanceHistoryCubit()),
          BlocProvider(create: (_) => AttendanceDetailCubit()),
          BlocProvider(create: (_) => LocalCubit()..getSavedLanguage()),
          BlocProvider(create: (_) => PayslipCubit()),
          BlocProvider(create: (_) => PayslipDetailCubit()),
          BlocProvider(create: (_) => ReimbursementCubit()),
          BlocProvider(create: (_) => ReimbursementCategoryCubit()),
          BlocProvider(create: (_) => TaskCubit()),
          BlocProvider(create: (_) => TaskDetailCubit()),
          BlocProvider(create: (_) => AssigneeCubit()),
          BlocProvider(create: (_) => EventsCubit()),
          BlocProvider(create: (_) => WorkingPeriodCubit()),
          BlocProvider(create: (_) => SalaryCubit()),
          BlocProvider(create: (_) => OfficeAssetsCubit()),
          BlocProvider(create: (_) => NotificationsCubit()),
        ],
        child: BlocBuilder<LocalCubit, LocalState>(builder: (_, state) {
          if (state is ChangeLocalState) {

            print("MAIN LANGUAGE ${state.locale}");

            return GetMaterialApp(
                locale: state.locale,
                supportedLocales: const [
                  Locale('ar', "AR"),
                  Locale('ms', "MS"),
                  Locale('en', "US"),
                  Locale("id", "ID"),
                ],
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                localeResolutionCallback: (currentLocal, supportedLocales) {

                  for (var locale in supportedLocales) {
                    if (currentLocal != null &&
                        currentLocal.languageCode == locale.languageCode) {

                      print("LOCALE LANGUAGE ${state.locale}");

                      return currentLocal;
                    }
                  }
                  return supportedLocales.first;
                },
                debugShowCheckedModeBanner: false,
                home: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    locale: state.locale,
                    supportedLocales: const [
                      Locale('ar', "AR"),
                      Locale('ms', "MS"),
                      Locale('en', "US"),
                      Locale("id", "ID"),
                    ],
                    localizationsDelegates: const [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    localeResolutionCallback: (currentLocal, supportedLocales) {

                      for (var locale in supportedLocales) {
                        if (currentLocal != null &&
                            currentLocal.languageCode == locale.languageCode) {

                          print("LOCALE LANGUAGE ${state.locale}");

                          return currentLocal;
                        }
                      }
                      return supportedLocales.first;
                    },
                    home: page));
          }
          return const SizedBox();
        })
    );
  }
}
