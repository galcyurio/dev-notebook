# Flutter에서 Firebase Cloud Messaging 사용

pubspec.yaml 파일에 다음과 같이 firebase_messaging 의존성을 추가합니다.
```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^0.4.1
  firebase_messaging: ^5.1.8     # 추가
```

## Dart/Flutter integration
먼저 Dart 코드에서 플러그인을 import하고 인스턴스화해야 합니다.

```dart
import 'package:firebase_messaging/firebase_messaging.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
```

다음으로 푸시 알림 수신 권한을 요청해야 합니다.
이를 위해서는 `_firebaseMessaging.requestNotificationPermissions()`를 호출하면 됩니다.
이 함수는 iOS에서 유저에게 확인받을 수 있는 권한 다이얼로그를 보여주고 Android에서는 아무것도 하지 않습니다.

마지막으로 `onMessage`, `onResume`, `onLaunch` 콜백함수를 `_firebaseMessaging.configure()`를 통해 등록하여 수신하는 메세지들을 다룰 수 있습니다.

## Android integration

1. (선택적, 추천) 사용자가 시스템 트레이에서 알림을 클릭할 때 앱에서 알림을 받으려면 <activity> 태그에 다음의 `intent-filter`를 포함해야 합니다.

```xml
<intent-filter>
    <action android:name="FLUTTER_NOTIFICATION_CLICK" />
    <category android:name="android.intent.category.DEFAULT" />
</intent-filter>
```

2. 아래의 Application.java 클래스를 추가하세요. 예제에서는 `net.slipp.flutter_firebase` 패키지에 추가하였습니다.


```java
package net.slipp.flutter_firebase;

 import io.flutter.app.FlutterApplication;
 import io.flutter.plugin.common.PluginRegistry;
 import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback;
 import io.flutter.plugins.GeneratedPluginRegistrant;
 import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService;

 public class Application extends FlutterApplication implements PluginRegistrantCallback {
   @Override
   public void onCreate() {
     super.onCreate();
     FlutterFirebaseMessagingService.setPluginRegistrant(this);
   }

   @Override
   public void registerWith(PluginRegistry registry) {
     GeneratedPluginRegistrant.registerWith(registry);
   }
 }
 ```

 3. `AndroidManifest.xml` 파일에서 application 클래스명을 변경하세요.
 ```xml
 <application android:name=".Application" ...>
 <!-- 또는 -->
 <application android:name="net.slipp.flutter_firebase.Application" ...>
 ```

4. 백그라운드 메세지를 처리할 top-level Dart 메서드 정의
```dart
 Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
   print("onBackgrounMessage: $message");
   
   if (message.containsKey('data')) {
     // Handle data message
     final dynamic data = message['data'];
   }

   if (message.containsKey('notification')) {
     // Handle notification message
     final dynamic notification = message['notification'];
   }

   // Or do other work.
 }
 ```
> `data`와 `notification`는 [RemoteMessage](https://firebase.google.com/docs/reference/android/com/google/firebase/messaging/RemoteMessage)에 정의된 필드들과 동일합니다.

5. `onBackgroundMessage`에 정의해둔 `myBackgroundMessageHandler` 메서드를 넘겨줍니다.
```dart
_firebaseMessaging.configure(
  onMessage: (Map<String, dynamic> message) async {
    print("onMessage: $message");
  },
  onBackgroundMessage: myBackgroundMessageHandler,
  onLaunch: (Map<String, dynamic> message) async {
    print("onLaunch: $message");
  },
  onResume: (Map<String, dynamic> message) async {
    print("onResume: $message");
  },
);
```

## iOS integration
https://pub.dev/packages/firebase_messaging#ios-integration

## 참고 문서
- https://pub.dev/packages/firebase_messaging