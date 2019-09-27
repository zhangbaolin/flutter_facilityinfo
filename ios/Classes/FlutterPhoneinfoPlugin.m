#import "FlutterPhoneinfoPlugin.h"

@implementation FlutterPhoneinfoPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_facilityinfo"
            binaryMessenger:[registrar messenger]];
  FlutterPhoneinfoPlugin* instance = [[FlutterPhoneinfoPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  }else if([@"getMac" isEqualToString:call.method]){


    result([YKeyChain identifierForVendor]);
  } else if([@"getUUID" isEqualToString:call.method]){
      result([YKeyChain identifierForVendor]);
   
  }else if([@"getIMEI" isEqualToString:call.method]){
    result([YKeyChain identifierForVendor]);
  }else if([@"getIdentifier" isEqualToString:call.method]){
    result([YKeyChain identifierForVendor]);
  }
   else {
    result(FlutterMethodNotImplemented);
  }
}





@end
