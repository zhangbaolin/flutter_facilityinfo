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
说明：
使用此插件可获取安卓手机的  IMEI  MAC  UUID  

getIdentifier（）
此方法具有获取信息的优先级  也可自行获取并设置
首先获取 IMEI  如为空 则获取 MAC  如为空 则获取UUID

<uses-permission android:name="android.permission.READ_PHONE_STATE" />
在使用插件方法获取信息之前需要先动态申请权限：
引入 permission_handler: ^3.2.2


 Future<Null> _prepare() async {
    isAlow = await _checkPermission();
    if (isAlow) {
      //允许执行下一步
    } else {
      print("获取权限失败");
    }
  }
// 检查权限
  Future<bool> _checkPermission() async {
    if (Platform.isAndroid) {
      PermissionStatus permission = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.phone);
      if (permission != PermissionStatus.granted) {
        Map<PermissionGroup, PermissionStatus> permissions =
            await PermissionHandler()
                .requestPermissions([PermissionGroup.phone]);
        if (permissions[PermissionGroup.phone] == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }



```
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
