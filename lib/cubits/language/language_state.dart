import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class LocalState {}

class LocalInitState extends LocalState {}

class ChangeLocalState extends LocalState {
  final Locale? locale;

  ChangeLocalState({@required this.locale});
}
