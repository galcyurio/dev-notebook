## Firebase 프로젝트 생성

## iOS 앱 구성
1. iOS 번들 ID에 `ios/Runner.xcodeproj/project.pbxproj` 파일에서 `PRODUCT_BUNDLE_IDENTIFIER`의 값을 입력합니다.
예제에서는 `net.slipp.flutterFirebase` 입니다.

2. 필요하다면 선택사항을 입력하고 앱 등록을 누릅니다.

3. .plist 파일을 다운로드 받고 `ios/Runner/` 디렉토리에 저장합니다.

4. Firebase 콘솔에서 나머지 설정 단계를 건너뜁니다.

5. FlutterFire 플러그인 추가

## Android 앱 구성
1. Android 패키지 이름에 `android/app/build.gradle` 파일에서 `applicationId`의 값을 입력합니다.
예제에서는 `net.slipp.flutter_firebase` 입니다.

2. 필요하다면 선택사항을 입력하고 앱 등록을 누릅니다.

3. .json 파일을 다운로드 받고 `android/app/` 디렉토리에 저장합니다.

4. `android/build.gradle` 파일에서 google-services 플러그인을 추가합니다.
```groovy
buildscript {
  repositories {
    google() // google repository 추가
  }
  dependencies {
    classpath 'com.google.gms:google-services:4.3.2'  // Google Services plugin 추가
  }
}
allprojects {
  repositories {
    google() // google repository 추가
  }
}
```

5. `android/app/build.gradle` 파일에서 google-services 플러그인을 적용합니다.
```groovy
// 파일의 가장 아래 라인에 추가
apply plugin: 'com.google.gms.google-services'
```

6. FlutterFire 플러그인 추가

## FlutterFire 플러그인 추가

> Flutter는 플러그인을 사용하여 Firebase API 등 다양한 플랫폼별 서비스에 대한 액세스를 제공합니다. 플러그인에는 각 플랫폼의 서비스 및 API에 액세스하기 위한 플랫폼별 코드가 포함되어 있습니다.

> 각 Firebase 제품(예: 데이터베이스, 인증, 애널리틱스, 저장소)에 하나씩 여러 다양한 라이브러리를 통해 Firebase에 액세스할 수 있습니다. Flutter는 일련의 Firebase 플러그인을 제공하며, 이를 총칭하여 FlutterFire라고 합니다.

> Flutter는 멀티 플랫폼 SDK이므로 각 FlutterFire 플러그인을 iOS와 Android 모두에 적용할 수 있습니다. 따라서 FlutterFire 플러그인을 Flutter 앱에 추가하면 Firebase 앱의 iOS 및 Android 버전 모두에서 사용됩니다.

1. pubspec.yaml 파일에서 firebase_core 플러그인을 추가합니다.

```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^0.4.1  # add dependency for Firebase Core
```

2. 사용하려는 Firebase 제품의 플러그인을 추가합니다.
플러그인 목록들은 [여기](https://firebaseopensource.com/projects/firebaseextended/flutterfire/#available_flutterfire%20plugins)에서 찾을 수 있습니다.


## 참고 문서
- https://firebase.google.com/docs/flutter/setup?hl=ko