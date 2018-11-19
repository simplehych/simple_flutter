package com.simple.simpleflutter;

import android.annotation.SuppressLint;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.Bundle;
import android.text.TextUtils;
import android.widget.Toast;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

import java.text.SimpleDateFormat;

public class MainActivity extends FlutterActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
        registerFlutterMethod();
        registerFlutterEventNetChanged();

    }

    public void registerFlutterMethod() {
        new MethodChannel(getFlutterView(), "com.simple.simpleflutter/android")
                .setMethodCallHandler(((methodCall, result) -> {
                    System.out.println(methodCall.method);
                    if (methodCall.method.equals("showToast")) {
                        if (methodCall.hasArgument("msg") && !TextUtils.isEmpty(methodCall.argument("msg").toString())) {
                            Toast.makeText(MainActivity.this, methodCall.argument("msg"), Toast.LENGTH_SHORT).show();
                        } else {
                            Toast.makeText(MainActivity.this, "toast text must not null", Toast.LENGTH_SHORT).show();
                        }
                    } else if (methodCall.method.equals("getAndroidTime")) {
                        result.success(getCurrentTime());
                    } else if (methodCall.method.equals("netConnection")) {
                        result.success(isNetworkConnected());
                    }
                }));
    }

    public void registerFlutterEventNetChanged() {
        new EventChannel(getFlutterView(), "com.simple.simpleflutter/netchanged")
                .setStreamHandler(new EventChannel.StreamHandler() {
                    private BroadcastReceiver netStateChangeReceiver;

                    @Override
                    public void onListen(Object o, EventChannel.EventSink eventSink) {
                        netStateChangeReceiver = new BroadcastReceiver() {
                            @Override
                            public void onReceive(Context context, Intent intent) {
                                eventSink.success(isNetworkConnected() ? "网络可用" : "网络不可用");
                            }
                        };
                        registerReceiver(netStateChangeReceiver, new IntentFilter(ConnectivityManager.CONNECTIVITY_ACTION));
                    }

                    @Override
                    public void onCancel(Object o) {
                        unregisterReceiver(netStateChangeReceiver);
                        netStateChangeReceiver = null;

                    }
                });
    }

    private String getCurrentTime() {
        return new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(System.currentTimeMillis());
    }

    private boolean isNetworkConnected() {
        ConnectivityManager connectivityManager = (ConnectivityManager) getSystemService(Context.CONNECTIVITY_SERVICE
        );
        @SuppressLint("MissingPermission") NetworkInfo activeNetworkInfo = connectivityManager.getActiveNetworkInfo();
        if (activeNetworkInfo != null && activeNetworkInfo.getState() == NetworkInfo.State.CONNECTED) {
            return true;
        }
        return false;
    }
}
