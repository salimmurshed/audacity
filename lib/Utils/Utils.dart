import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Saving APi Response
saveResponse(String key, String value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
  return value;
}

//Get Response

Future<String> getResponse(String key) async {
  final prefs = await SharedPreferences.getInstance();
  final value = prefs.getString(key);
  if (value == null) {
    return null;
  } else {
    return value;
  }
}

//Checking Internet
Future<bool> isOnline() async {
  final Connectivity _connectivity = Connectivity();
  ConnectivityResult result = await _connectivity.checkConnectivity();
  switch (result) {
    case ConnectivityResult.wifi:
      return true;
      break;
    case ConnectivityResult.mobile:
      return true;
      break;
    case ConnectivityResult.none:
      return false;
      break;
    default:
      return false;
      break;
  }
}

newText(text) {
  return Text(
    text,
    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
  );
}
