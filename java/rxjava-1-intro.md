- [참고 문서](https://github.com/Froussios/Intro-To-RxJava/blob/master/Part%201%20-%20Getting%20Started/1.%20Why%20Rx.md)

## Rx를 왜 쓸까?
유저는 자신이 실행한 것에 대해 바로 결과를 얻고 싶어한다. 
하지만 실제 결과가 도착하는 것을 기다리고 도착한 후에 다른 작업을 수행하는 것은 상당히 힘들다. 
우리는 결과를 기다리는 동안 쓰레드가 블럭되는 것을 원치 않으며 결과가 준비되면 바로 유저에게 보여주고 싶어한다.
또한 모든 결과가 처리되지 않고 일부의 결과만이 준비되어도 바로 유저에게 보여줄 수 있어야 한다.

Rx는 다음과 같은 장점이 있다.
- Unitive
  - Rx의 쿼리는 자바의 스트림과 같은 함수형 프로그래밍에서 영감을 받은 다른 라이브러리들과 동일한 스타일이다.
- Extensible
  - RxJava는 custom operator를 확장하여 쓸 수 있다. Java에서 이를 우아한 형태로 쓸 수는 없지만 RxJava는 다른 언어의 Rx 구현체들에서 볼 수 있는 확장성을 제공한다.
- Declarative
  - functional transformation을 선언적인 방식으로 읽을 수 있다.
- Composable
  - Rx operator들은 복잡한 작업을 위해 결합 될 수 있다.
- Transformative
  - Rx operator들은 한 유형의 데이터를 다른 유형으로 변환할 수 있으며 스트림을 reducing, mapping, expanding 할 수 있다.


## 언제 Rx가 적합할까?
Rx는 여러개의 이벤트를 다룰 때 적합하다.

### 반드시 Rx를 써야하는 경우
- 마우스 이동, 버튼 클릭과 같은 UI 이벤트 처리
- 속성 변경, collection 업데이트와 같은 도메인 이벤트 (주문 완료, 등록 승인)
- 파일 감시자, 시스템 이벤트와 같은 infrastructure 이벤트
- 메세지 버스나 웹소켓, low latency인 미들웨어인 Nirvana의 푸시 이벤트와 같은 통합 이벤트
- StreamInsight 또는 StreamBase와 같은 CEP(Complex Event Processing) 엔진 통합


### Rx를 써야하는 경우
- `Future`와 같은 패턴의 결과

### Rx가 필요없는 경우
- `Iterable`을 `Observable`로 단순 변환하여 Rx 라이브러리를 통해 작업하는 경우