import "package:dio/dio.dart";
import 'package:flutter/cupertino.dart';

import 'injector.dart';

Future<void> configure() async {
  WidgetsFlutterBinding.ensureInitialized();
  injector.registerSingleton<Dio>(Dio());
}