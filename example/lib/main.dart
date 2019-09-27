import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_facilityinfo/flutter_facilityinfo.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _mac = "MAc 不存在";
  String _uuid = "UUID 不存在";
  String _imei = "IMEI 不存在";
  String _identifier = "唯一标识";
  bool isAlow = false;

  @override
  void initState() {
    super.initState();

    _prepare();
  }

  Future<Null> _prepare() async {
    String mac = "";
    isAlow = await _checkPermission();
    if (isAlow) {
      initPlatformState();
    } else {
      print("获取权限失败");
      mac = await FlutterPhoneinfo.getMac;
      setState(() {
        _mac = mac;
      });
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

  Future<void> initPlatformState() async {
    String platformVersion;
    String uuid;
    String mac;
    String imei;
    String identifier;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterPhoneinfo.platformVersion;

      mac = await FlutterPhoneinfo.getMac;
      uuid = await FlutterPhoneinfo.getUUID;
      identifier = await FlutterPhoneinfo.getIdentifier;
      imei = await FlutterPhoneinfo.getIMEI;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _mac = mac;
      _uuid = uuid;
      print("$uuid");
      _identifier = identifier;
      _imei = imei;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text('_platformVersion: $_platformVersion\n'),
              Text('_mac: $_mac\n'),
              Text('_uuid: $_uuid\n'),
              Text('_imei$_imei\n'),
              Text('唯一标识: $_identifier\n'),
            ],
          ),
        ),
      ),
    );
  }
}
