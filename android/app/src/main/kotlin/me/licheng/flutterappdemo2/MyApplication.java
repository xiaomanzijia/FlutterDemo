package me.licheng.flutterappdemo2;

import android.content.Context;
import android.support.multidex.MultiDex;

import io.flutter.app.FlutterApplication;

/**
 * Created by changyuan on 2018/7/21.
 */
public class MyApplication extends FlutterApplication {
    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(base);
        try {
            MultiDex.install(base);
        } catch (Exception ignored) {
        }
    }
}
