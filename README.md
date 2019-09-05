# flutter_facilityinfo

A new Flutter plugin.

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.

[Usage]
Import package:flutter_facilityinfo/flutter_facilityinfo.dart, instantiate PhonePlug and use the Android and iOS getters to get platform-specific device information.

主要是为了获取手机的唯一标识，先获取手机的mac地址，如果mac地址不存在，再去获取UUID。
### Example:

```dart
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_facilityinfo/flutter_facilityinfo.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _deviceid = 'Unknown';

  @override
  void initState() {
    super.initState();
    initDeviceId();
  }

  Future<void> initDeviceId() async {
    String deviceid;

    deviceid = await FlutterPhoneinfo.getIdentifier;
   String mac=await FlutterPhoneinfo.getMac;
   String uuid=await FlutterPhoneinfo.getUUID;
    if (!mounted) return;

    setState(() {
      _deviceid = 'deviceid:  $deviceid';
     
      print('$_deviceid');
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Device Id example app'),
        ),
        body: new Center(
          child: new Text('$_deviceid'),
        ),
      ),
    );
  }
}

```
