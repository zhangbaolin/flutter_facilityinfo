package com.pluging.flutter_facilityinfo;

import android.annotation.SuppressLint;
import android.content.Context;
import android.telephony.TelephonyManager;
import android.text.TextUtils;

import java.lang.reflect.Method;
import android.content.Context;
import android.os.Build;
import android.telephony.TelephonyManager;
public class ImeiManger {


     

    public static String getIMEI(Context context) {
        //Log.e("来了","真的来了");
        TelephonyManager telephonyManager = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
        String asd="";
        if (telephonyManager != null) {
            String imei;
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                imei = telephonyManager.getImei();
            }
            else {
                imei = telephonyManager.getDeviceId();
            }
            asd=imei;
        }
        return asd;
    }
}

