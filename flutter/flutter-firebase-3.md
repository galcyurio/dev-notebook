# Flutter에서 Firestore 사용


1. Firebase 콘솔에서 Firestore 데이터베이스를 생성합니다.

2. pubspec.yaml 파일에 `cloud_firestore` 의존성을 추가합니다.
```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^0.4.1
  cloud_firestore: ^0.12.10
```

위의 작업으로 모든 설정은 끝입니다.
아래와 같이 문서를 읽고 쓸 수 있습니다.

### 읽기

```dart
Firestore.instance
  .collection("misc-collection")
  .document("misc-document")
  .get()
  .then((DocumentSnapshot ds) {
    ds.data["foo"] // do something
  });
```

### 실시간 읽기 
```dart
Firestore.instance
  .collection("misc-collection")
  .document("misc-document")
  .snapshots()
  .listen((DocumentSnapshot ds) {
    ds.data["foo"] // do something
  });
```

### 쓰기
```dart
Firestore.instance
    .collection("misc-collection")
    .document("misc-document")
    .setData({"foo": "something"});
```
