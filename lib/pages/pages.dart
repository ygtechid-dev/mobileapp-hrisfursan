import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiver/iterables.dart';
// import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supercharged/supercharged.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:intl/intl.dart' as intl;
import 'package:url_launcher/url_launcher.dart';

import '../shared/shared.dart';
import '../utils/helper.dart';
import '../widgets/widgets.dart';

part "general_page.dart";
part "intro/splash_page.dart";
part "auth/signin_page.dart";
part "auth/signup_page.dart";
part "auth/personal_data_page.dart";
part "main/main_page.dart";
part "main/activity_page.dart";
part "main/analytics_page.dart";
part "main/attendance_page.dart";
part "main/home_page.dart";
part "main/profile_page.dart";

String prefixIcons = "assets/icons/";
String prefixImages = "assets/images/";