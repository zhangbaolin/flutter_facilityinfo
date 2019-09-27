import 'dart:async';

import 'package:flutter/services.dart';

class FlutterPhoneinfo {
  static const MethodChannel _channel =
      const MethodChannel('flutter_facilityinfo');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  //获取mac
  static Future<String> get getIMEI async {
    final String imei = await _channel.invokeMethod('getIMEI');
    return imei;
  }
  //获取mac
  static Future<String> get getMac async {
    final String mac = await _channel.invokeMethod('getMac');
    return mac;
  }

  //获取uuid
  static Future<String> get getUUID async {
    final String meid = await _channel.invokeMethod('getUUID');
    return meid;
  }

    //获取存在的唯一标识
  static Future<String> get getIdentifier async {
    final String identifier = await _channel.invokeMethod('getIdentifier');
    return identifier;
  }

  
}
