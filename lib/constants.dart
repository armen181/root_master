import 'package:flutter/material.dart';

const kSecondaryColor = Colors.white;
const kGreenColor = Color(0xFF6AC259);
const kRedColor = Color(0xFFE92E30);
const kGrayColor = Color(0xFFA1D2C2);
const kBlackColor = Color(0xFF101010);
const kPrimaryGradient = LinearGradient(
  colors: [Colors.lightGreen, Colors.cyanAccent],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

const double kDefaultPadding = 20.0;
const String baseUrl = "http://192.168.4.67:8080";
const String roomUri = "/room";
const String playerUri = "/player";
const String startUri = "/start";
const String joinUri = "/room/join";
