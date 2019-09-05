import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_facilityinfo/flutter_facilityinfo.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_facilityinfo');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FlutterPhoneinfo.platformVersion, '42');
  });
}
