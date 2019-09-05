package com.pluging.flutter_facilityinfo;


import android.app.Activity;


import java.util.UUID;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;


/**
 * FlutterPhoneinfoPlugin
 */
public class FlutterPhoneinfoPlugin implements MethodCallHandler {
    /**
     * Plugin registration.
     */

    private final MethodChannel channel;
    private Activity activity;

    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_facilityinfo");
        channel.setMethodCallHandler(new FlutterPhoneinfoPlugin(registrar.activity(), channel));
    }

    private FlutterPhoneinfoPlugin(Activity activity, MethodChannel channel) {
        this.activity = activity;
        this.channel = channel;
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);
        } else if (call.method.equals("getMac")) {
            result.success(AllMacUtil.getMac(activity));
        } else if (call.method.equals("getUUID")) {
            result.success(getMyUUid());
        } else if (call.method.equals("getIdentifier")){
              result.success(getIdentifier());
        }else {
            result.notImplemented();
        }
    }

    /**
     * 获取uuid
     * @return
     */
    public String getMyUUid() {
        String uuid;

        UUID uuid1 = UUID.randomUUID();
        uuid = uuid1.toString();
          if (uuid.isEmpty()){
              uuid="";
          }
        return uuid;
    }


    public  String getIdentifier(){
        String  result;
      String  macString = AllMacUtil.getMac(activity);
      String  uuid=getMyUUid();
        if (!macString.isEmpty()){
            result=macString;
        }else {
          if (!uuid.isEmpty()){
             result=uuid;
          }else {
              result="0";
          }
        }
        return  result;
    }
}
