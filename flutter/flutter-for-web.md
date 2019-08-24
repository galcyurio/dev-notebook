# Flutter for Web

Flutter for web은 표준 기반 웹 기술 (HTML, CSS 및 JavaScript)을 사용하여 렌더링되는 Flutter의 코드 호환 구현입니다.
Flutter for web을 사용하면 Dart로 쓰여진 기존 Flutter 코드를 브라우저에 내장가능하며 어느 웹 서버로도 배포할 수 있는 클라이언트 환경으로 컴파일 할 수 있습니다.
Flutter의 모든 기능을 사용할 수 있으며 브라우저 플러그인을 사용하지 않아도 됩니다.

> **주의:** Flutter for web은 현재 기술 미리보기로 제공됩니다.
> Flutter for web을 시도할 때 충돌이 발생하거나 기능이 누락될 수 있습니다.
> 자세한 내용은 [Flutter for web README](https://github.com/flutter/flutter_web/blob/master/README.md)를 참조하세요.

시작하는 방법은 이 [저장소](https://github.com/flutter/flutter_web)를 확인하세요.

웹 지원을 추가하려면 표준 브라우저 API 위에 Flutter의 핵심 도면 레이어를 구현해야합니다.
DOM, Canvas, CSS의 조합을 사용하여 최신 브라우저에서 이식성이 뛰어난 고성능 사용자 환경을 제공할 수 있습니다.
우리는 이 코어 드로잉 레이어를 Dart에서 완벽하게 구현했으며 Dart의 최적화 된 JavaScript 컴파일러를 사용하여 Flutter 코어와 프레임 워크를 응용 프로그램과 함께 하나의 축소 된 소스 파일로 컴파일하여 모든 웹 서버에 배포 할 수 있습니다.

이 초기 개발 단계에서는 많은 시나리오에서 웹용 Flutter가 유용 할 것으로 예상합니다. 예를 들면 다음과 같습니다.
* Flutter로 빌드 된 연결된 Progressive Web Application입니다. Flutter에 대한 웹 지원을 통해 기존 모바일 기반 애플리케이션을 PWA로 패키징하여 더 다양한 장치에 도달하거나 기존 앱에 동반 웹 환경을 제공 할 수 있습니다.
* 내장된 대화형 컨텐츠. Flutter는 기존 웹 페이지에 쉽게 호스팅할 수 있는 풍부한 데이터 중심 구성 요소를 만들 수 있는 강력한 환경을 제공합니다. Flutter는 데이터 시각화, 자동차 구성 도구와 같은 온라인 도구 또는 내장형 차트에 상관없이 내장 웹 컨텐츠에 대한 생산적인 개발 방식을 제공할 수 있습니다.
* Flutter 모바일 앱에 동적인 컨텐츠를 포함합니다. 기존 모바일 애플리케이션 내에서 동적 컨텐츠 업데이트를 제공하는 확립 된 방법은 정보를 동적으로 로드하고 표시할 수 있는 web view control를 사용하는 것입니다.


## 시작하기
Flutter 1.5 이상부터 Dart를 컴파일해서 JavaScript를 포함하여 Flutter로 웹을 타겟팅할 수 있습니다.
flutter_web 미리보기에서 Flutter SDK를 사용하려면 시스템에서 flutter 업그레이드를 실행하여 Flutter를 v1.5.4 이상으로 업그레이드했는지 확인하세요.

### flutter 설치
flutter_web을 사용하기 전에 먼저 flutter를 다운로드하고 설치해야 합니다.
flutter 설치는 아래 페이지를 참고해주세요.

[Flutter 설치 공식문서](https://flutter.dev/docs/get-started/install)

### flutter_web 소스코드 clone
```bash
git clone https://github.com/flutter/flutter_web.git
```

그리고 `$HOME/.pub-cache/bin` 디렉토리가 `path`에 등록해서 `webdev` 명령어를 터미널이 어느 위치에 있는 실행할 수 있게 만드세요.
> 만약 webdev 명령어를 실행하는데 문제가 생겼다면 대신 다음 명령어를 사용하세요.
>
> flutter pub global run webdev [command].

만약 webdev 명령어를 수행했을 때 dart 명령어를 수행하지 못한다면 dart sdk 위치를 path에 등록해주면 됩니다.
flutter 내부에서 다운로드해놓은 dart-sdk의 위치는 다음과 같습니다.

```bash
# 윈도우
flutter\bin\cache\dart-sdk

# 리눅스
flutter/bin/cache/dart-sdk
```

### hello_world 예제 실행하기
`flutter_web` repository를 정상적으로 clone 하셨다면 다음의 위치에 hello_world 예제가 있을겁니다.
hello_world가 flutter_web에 의존성이 있기 때문에 다른 위치로 복사하면 빌드가 제대로 되지 않습니다.

```bash
cd dev/hello_world
```

그리고 패키지들을 업데이트합니다.
```bash
$ flutter pub upgrade
! flutter_web 0.0.0 from path ..\..\packages\flutter_web
! flutter_web_ui 0.0.0 from path ..\..\packages\flutter_web_ui
Running "flutter pub upgrade" in hello_world...                    59.9s
```

위와 같이 나온다면 성공한 것이며 실행할 수 있습니다.
빌드를 수행하고 로컬에 배포해봅시다.

```bash
$ webdev serve
[INFO] Building new asset graph completed, took 4.1s
[INFO] Checking for unexpected pre-existing outputs. completed, took 2ms
[INFO] Serving `web` on http://127.0.0.1:8080
[INFO] Running build completed, took 47.7s
[INFO] Caching finalized dependency graph completed, took 214ms
[INFO] Succeeded after 47.9s with 557 outputs (3260 actions)
[INFO] --------------------------------------------------------------------
```

이제 <http://localhost:8080>을 열어서 확인해보면 왼쪽 상단에 `Hello World`가 빨간색 텍스트로 표시됩니다.

![](images/flutter_web_hello_world.png)