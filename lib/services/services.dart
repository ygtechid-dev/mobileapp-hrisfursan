import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

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


// String baseUrl = 'https://grahasahid.yuvan.dev/api/';
String baseUrl = 'http://103.196.155.202:3333/api/';
String baseUrlFcm = 'https://fcm.googleapis.com/fcm/send';