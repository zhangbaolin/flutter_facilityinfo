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
            result.success(" Android" + android.os.Build.VERSION.RELEASE);
        } else if (call.method.equals("getMac")) {
            result.success( AllMacUtil.getMac(activity));
        } else if (call.method.equals("getUUID")) {
            result.success(getMyUUid());
        } else if (call.method.equals("getIMEI")) {
            result.success(getMyIMEI());
        } else if (call.method.equals("getIdentifier")) {
            result.success(getIdentifier());
        } else {
            result.notImplemented();
        }
    }

    /**
     * 获取uuid
     *
     * @return
     */
    public String getMyIMEI() {
        String imei = "";
        imei = ImeiManger.getIMEI(activity);
        if (imei.isEmpty()) {
            imei = "";
        }
        return imei;
    }

    /**
     * 获取uuid
     *
     * @return
     */
    public String getMyUUid() {
        String uuid = "";
        uuid = UUIdManger.getDevUUID(activity);
        if (uuid.isEmpty()) {
            uuid = "";
        }

        return uuid;
    }

    public String getIdentifier() {
        String result;
        String myImei = getMyIMEI();
        String myMac = AllMacUtil.getMac(activity);
        String myUUid = getMyUUid();

        if (!myImei.isEmpty()) {
            // imei不为空
            result = myImei;

        } else {
            // imei为空 判断mac
            if (!myMac.isEmpty()) {
                result = myMac;

            } else {
                // mac为空 判断uuid
                if (!myUUid.isEmpty()) {
                    result = myUUid;
                } else {
                    // 都为空 返回空
                    result = "";
                }
            }

        }
        return result;
    }

}
