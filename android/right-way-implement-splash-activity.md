# 첫번째 글
[Original link](https://www.bignerdranch.com/blog/splash-screens-the-right-way/)

## 요약
구글은 material design spec 에 까지 splash screen 을 올려놓았지만 
오히려 anti-pattern 이라고 주장하기도 했다.

나는 구글의 주장이 모순된 것이 아니라 단순히 splash screen 을 유저의 시간을 낭비하는 데에 쓰지 말라는 것으로 믿고 있다.  
구글의 주장은 cold start 의 경우에는 start 시간이 굉장히 오래 걸리는데 이 경우에 그냥 빈 화면을 보여주지 말고 유저의 시간을 낭비시키지 않는 선에서 splash screen 을 보여주자는 것이다.

유튜브가 좋은 예제이다.

![Youtube](https://www.bignerdranch.com/assets/img/blog/2015/08/youtube_splash.gif)

## Splash screen 의 구성하는 방법
1. layout file 을 사용하지 않는다.
2. Specify your splash screen’s background as the activity’s theme background. first create an XML drawable in res/drawable
````xml
<?xml version="1.0" encoding="utf-8"?>
<layer-list xmlns:android="http://schemas.android.com/apk/res/android">

    <item
        android:drawable="@color/gray"/>

    <item>
        <bitmap
            android:gravity="center"
            android:src="@mipmap/ic_launcher"/>
    </item>

</layer-list>
````

3.  You will set this as your splash activity’s background in the theme. Navigate to your styles.xml file and add a new theme for your splash activity
````xml
<resources>

    <!-- Base application theme. -->
    <style name="AppTheme" parent="Theme.AppCompat.Light.DarkActionBar">
        <!-- Customize your theme here. -->
    </style>

    <style name="SplashTheme" parent="Theme.AppCompat.NoActionBar">
        <item name="android:windowBackground">@drawable/background_splash</item>
    </style>

</resources>
````

4. In your new SplashTheme, set the window background attribute to your XML drawable. Configure this as your splash activity’s theme in your AndroidManifest.xml:

````xml
<activity
    android:name=".SplashActivity"
    android:theme="@style/SplashTheme">
    <intent-filter>
        <action android:name="android.intent.action.MAIN" />

        <category android:name="android.intent.category.LAUNCHER" />
    </intent-filter>
</activity>
````

5. Finally, your SplashActivity class should just forward you along to your main activity:
````java
public class SplashActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        Intent intent = new Intent(this, MainActivity.class);
        startActivity(intent);
        finish();
    }
}
````

Splash screen 에서 할 건 아무것도 없고 theme 에 설정한 대로 두면 된다.
만약 layout file 을 통해서 splash screen 을 보여주고 있다면 그 화면은 앱이 모두 초기화 된 다음에 보여질 것입니다. 너무 느려.



# 두번째 글
[Original link](https://android.jlelse.eu/right-way-to-create-splash-screen-on-android-e7f1709ba154)

## 요약
### Common mistakes
잘 알려진 방법들 대로 splash 화면을 구성하다보면 blank 화면이 뜰 수도 있고 유저의 시간을 낭비시킬 수도 있다.

### Right way
- background 색깔을 보여주기 위해 theme 을 이용한다.
- white page problem 을 없애기 위해 layout file 을 사용하지 않는다.


### 구현
1. Create an XML drawable splash_background.xml inside res/drawable folder:
````xml
<?xml version=”1.0" encoding=”utf-8"?>
 <layer-list xmlns:android=”http://schemas.android.com/apk/res/android">

  <item android:drawable=”@color/colorPrimary” />

  <item>
    <bitmap
      android:gravity=”center”
      android:src=”@mipmap/ic_launcher” />
  </item>

</layer-list>
````
2. Set splash_background.xml as your splash activity’s background in the theme. Add a new SplashTheme for your splash activity:
````xml
<resources>
    <!-- Base application theme. -->
    <style name="AppTheme" parent="Theme.AppCompat.Light.DarkActionBar">
        <!-- Customize your theme here. -->
        <item name="colorPrimary">@color/colorPrimary</item>
        <item name="colorPrimaryDark">@color/colorPrimaryDark</item>
        <item name="colorAccent">@color/colorAccent</item>
    </style>
    <!-- Splash Screen theme. -->
    <style name="SplashTheme" parent="Theme.AppCompat.NoActionBar">
        <item name="android:windowBackground">@drawable/splash_background</item>
    </style>
</resources>
````


3. Configure SplashTheme as your splash activity’s theme in your AndroidManifest.xml:
````xml
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.androidjavapoint.splashscreen">
    <application
        android:allowBackup="true"
        android:icon="@mipmap/ic_launcher"
        android:label="@string/app_name"
        android:supportsRtl="true"
        android:theme="@style/AppTheme">
        <activity
            android:name=".SplashActivity"
            android:theme="@style/SplashTheme">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
        <activity android:name=".HomeActivity" />
    </application>
</manifest>
````

4. Create an empty activity for Splash without XML layout file. This class will simply redirect to home activity.

````java
package com.androidjavapoint.splashscreen;
import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
public class SplashActivity extends AppCompatActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // Start home activity
        startActivity(new Intent(SplashActivity.this, HomeActivity.class));
        // close splash activity
        finish();
    }
}
````