import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_facilityinfo/flutter_facilityinfo.dart';
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _mac = "MAc 不存在";
  String _uuid="UUID 不存在";

  String _identifier="唯一标识";

  @override
  void initState() {
    super.initState();
    initPlatformState();
   // applyPermission(context);
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    String uuid;
    String mac;
    String identifier;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterPhoneinfo.platformVersion;
     
      mac = await FlutterPhoneinfo.getMac;
      uuid=await FlutterPhoneinfo.getUUID;
      identifier=await  FlutterPhoneinfo.getIdentifier;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _mac = mac;
      _uuid=uuid;
      _identifier=identifier;
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
              Text('Running on: $_platformVersion\n'),
              Text('Running on: $_mac\n'),
             Text('Running on: $_uuid\n'),

              Text('唯一标识: $_identifier\n'),
            ],
          ),
        ),
      ),
    );
  }


}