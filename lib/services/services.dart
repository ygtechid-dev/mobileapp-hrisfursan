import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:crypto/crypto.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../models/models.dart';
import '../pages/pages.dart';
import '../shared/shared.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

part 'user_services.dart';
part 'leave_services.dart';
part 'designation_services.dart';
part 'overtimes_services.dart';
part "attendance_services.dart";
part "task_services.dart";
part "reimbursement_services.dart";
part "payslip_services.dart";
part "notification_services.dart";
part "events_services.dart";


// String baseUrl = 'https://grahasahid.yuvan.dev/api/';
String baseUrl = 'http://103.196.155.202:3333/api/';
// String baseUrl = 'http://10.216.53.224:8000/api/';
String baseUrl2 = 'http://103.196.155.202:3333/storage/';
String baseUrlFcm = 'https://fcm.googleapis.com/fcm/send';