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


## Getting Started
TODO