- [참고 문서](https://github.com/Froussios/Intro-To-RxJava/blob/master/Part%201%20-%20Getting%20Started/2.%20Key%20types.md)

# Key types
Rx는 2개의 기본적인 type을 기반으로 하며, 일부는 핵심 type을 중심으로 기능을 확장한다.
2개의 핵심적인 type은 `Observable`과 `Observer`이며 러닝커브를 낮춰줄 `Subject`들과 함께 이 글에서 다루어진다.

Rx는 옵저버 패턴을 기반으로 한다. 이 것은 특별한 것은 아니다. 자바에도 이미 이벤트 핸들링이 존재한다. 같은 접근 방식이지만 Rx와 비교하면 사용하기에 고통스럽다.

- 이벤트 핸들러를 통한 이벤트는 작성하기가 어렵다.
- 시간이 지나면 다룰 수가 없다.
- 메모리 누수가 일어날 수 있다.
- 완료 시그널에 대해 표준 방법이 없다.
- 동시성과 멀티쓰레딩을 수동적인 처리가 필요하다.


## Observable
이 클래스에는 모든 핵심 operator를 포함한 Rx 구현체가 포함되어 있다. 일단은 `subsribe` 메서드에 관해서 이해해야 한다.

````java
public final Subscription subscribe(Subscriber<? super T> subscriber)
````
이 메서드는 observable이 방출한 값들을 받을 수 있도록 한다. 이 값들은 consumer가 해당 행동에 대해 책임이 주어진 subscriber들에 push된다.

하나의 observable은 3가지의 이벤트를 보낸다.
- 값
- 완료 (더 이상 보낼 값이 없음을 나타낸다)
- 에러 (무언가가 시퀀스를 실패하게 하는 경우, 종료를 의미)


## Observer
`Subscriber`는 `Observer`의 추상적인 구현체이다.
`Subscriber`는 몇개의 추가적인 기능과 `Observer`의 기본적인 것들의 구현체이다.

````java
interface Observer<T> {
    void onCompleted();
    void onError(java.lang.Throwable e);
    void onNext(T t);
}
````
세 개의 메서드들은 observable이 값을 push할 때마다 실행된다.
`onNext`는 __0 ~ N__번 수행될 수 있으며 그 뒤에 `onCompleted` 또는 `onError` 메서드 둘 중 하나를 통해 끝난다.
`onCompleted`와 `onError` 호출이 일어난 후에는 다른 어떠한 호출도 일어나지 않는다.

Rx 코드를 통해 개발하면 많은 `Observable`을 볼 수 있지만 `Observer`의 경우는 그렇지 않다. 
`Observer`를 이해하는 것도 중요하지만 직접 인스턴스화하지 않고 쓸 수 있는 방법도 있다.


## Observable 과 Observer 구현하기
`Observer`를 직접 구현하거나 `Observable`을 extend할 수 있다. 
하지만 Rx에서 우리가 필요로 할만한 것들을 미리 제공하기 때문에 실제로는 필요가 없다.
또한 Rx의 part들 끼리의 interaction에는 convention과 내부적인 연관들이 있어서 초보자에게는 쉽지 않다.
우리가 필요한 기능들을 위해 Rx에서 제공하는 도구들을 사용하는 것이 더욱 간단하고 안전하다.

observable을 subscribe하려면 `Observer`의 인스턴스를 넘겨줄 필요가 전혀 없다.
`onNext`, `onError` 그리고 `onSubscribe`에서 실행될 함수를 받아서 해당 `Observer`의 인스턴스화를 숨길 수 있는 subscribe 메서드를 overload한 여러 메서드들이 있다.
그리고 각 함수를 모두 넘겨줄 필요도 없다. `onNext`만 또는 `onNext`, `onError`만 넘겨줄 수 있다.

자바 1.8에서 소개된 람다식은 이러한 overload 메서드들을 같이 사용하면 굉장히 편리하다.


## Subject
Subject는 `Observable`의 확장이며 또한 `Observer` 인터페이스의 구현체이다.
이건 처음보면 조금 이상하지만 어떠한 경우에는 훨씬 더 간단해진다.
Subject는 oberserver처럼 이벤트들을 받을 수도 있고 observable처럼 자신의 subscriber들에게 이벤트를 보낼 수도 있다.
이를 이용하면 Rx 코드에 이상적인 진입점을 만들 수 있다.
만약 Rx 바깥에서 값들을 받는 경우에 `Subject`로 값을 보내준 다음 `Subject`를 observable로 쓸 수 있다.
이 Subject들을 Rx 파이프라인에 대한 진입점으로 생각하면 된다.

`Subject`는 두가지 매개변수 type으로 input type과 output type이 존재한다.
이러한 이유는 추상화를 위한 것이지 subject를 값은 변형하기 위한 기본적인 사용 방법같은게 아니다.

`Subject`는 몇 가지 구현체가 있고 가장 중요한 것들과 그 차이점을 살펴보도록 한다.


### PublishSubject
`PublishSubject`는 가장 간단한 형태의 subject이다.
값이 `PublishSubject`로 전달되면 subject는 해당 순간에 구독하고 있는 subscriber들에게 값이 푸시된다.

````java
public static void main(String[] args) {
	PublishSubject<Integer> subject = PublishSubject.create();
	subject.onNext(1);
	subject.subscribe(System.out::println);
	subject.onNext(2);
	subject.onNext(3);
	subject.onNext(4);
}
````

Output
````
2
3
4
````

예제를 보면 `1`은 구독하기 전에 푸시되었기 때문에 출력되지 않았다.
구독한 이후부터 subject에서 값을 받기 시작하였다.

`subscribe`가 사용되는 것을 처음 보는 것이므로 사용법을 자세히 보자.
이 경우에는 하나의 함수를 받는 `onNext` 메서드를 사용했다.
이 함수는 `Integer`를 받고 아무것도 반환하지 않는다.
이렇게 반환 type이 없는 함수를 `Action`이라고도 한다.
이런 함수를 다음과 같이 여러가지 방법으로 전달할 수 있다.

- `Action1<Integer>`의 인스턴스를 전달할 수 있다.
- 람다식을 이용하여 암시적으로 하나를 생성하거나
- signature에 맞는 기존 method reference를 전달한다. 
  - 예제의 경우는 `System.out::println`가 `Object`를 받아들이는 오버로드 메서드가 전달된다. `subscribe`는 도착한 값을 인수로 사용하여 `println`을 호출한다.


### ReplaySubject
`ReplaySubject`는 푸시된 값들을 모두 캐시하는 특별한 기능을 가지고 있다.
새로운 subscription이 만들어 졌을 때 새로운 subscriber는 처음부터 이벤트 시퀀스가 재생(replay)된다.
새로운 subscriber가 모든 이벤트를 최신까지 따라잡고 난 뒤에는 모든 subscriber들은 새로운 이벤트를 받는다.

하나가 늦더라도 모든 값을 subscriber가 받는다.
또한 늦게 구독한 subscriber는 다음 값을 처리하기 전에 이전의 모든 값을 재생(replay)한다.

모든 것을 캐싱하는 것이 항상 좋은 것은 아니다.
오랜 시간 동안 observable 시퀀스가 돌아가기 때문이다.
몇 가지 내부 버퍼의 크기를 제한하는 방법이 있다.
`ReplaySubject.createWithSize` 메서드는 버퍼의 크기를 제한하고 `ReplaySubject.createWithTime` 메서드는 얼마가 길게 객체를 보관하는지 제한할 수 있다.

````java
ReplaySubject<Integer> s = ReplaySubject.createWithSize(2);	
s.onNext(0);
s.onNext(1);
s.onNext(2);
s.subscribe(v -> System.out.println("Late: " + v));	
s.onNext(3);
````

Output
````
Late: 1
Late: 2
Late: 3
````

subscriber가 크기 2의 버퍼 때문에 첫번째 값을 놓치게 된다.
마찬가지로 `createWithTime`을 사용하여 subject를 만들면 시간이 경과함에 따라 오래된 값이 버퍼에서 사라진다.

````java
ReplaySubject<Integer> s = ReplaySubject.createWithTime(150, TimeUnit.MILLISECONDS,
                                                        Schedulers.immediate());
s.onNext(0);
Thread.sleep(100);
s.onNext(1);
Thread.sleep(100);
s.onNext(2);
s.subscribe(v -> System.out.println("Late: " + v));	
s.onNext(3);
````

Output
````
Late: 1
Late: 2
Late: 3
````

`ReplaySubject.createWithTime`은 Rx 방식으로 시간을 지키기 위해 `Scheduler`를 필요로 한다.
현재는 이것을 무시해도 좋지만 동시성과 관련된 챕터에서 이것을 설명할 것이다.

`ReplaySubject.createWithTimeAndSize`는 둘 모두를 제한한다. 하나가 걸려도 버퍼에서 삭제된다.

### BehaviorSubject
`BehaviorSubject`는 오직 마지막 값만 기억한다.
이것은 버퍼 크기가 1인 `ReplaySubject`와 유사하다.
생성시에 초기값을 전달할 수 있으므로 구독시에 즉시 값을 사용할 수 있다.

````java
BehaviorSubject<Integer> s = BehaviorSubject.create();
s.onNext(0);
s.onNext(1);
s.onNext(2);
s.subscribe(v -> System.out.println("Late: " + v));	
s.onNext(3);
````

Output
````
Late: 2
Late: 3
````

마지막에 `onComplete` 또는 `onError`가 호출되면 바로 그것이 마지막 이벤트가 된다.

````java
BehaviorSubject<Integer> s = BehaviorSubject.create();
s.onNext(0);
s.onNext(1);
s.onNext(2);
s.onComplete();
s.subscribe(
	v -> System.out.println("Late: " + v),
	e -> System.out.println("Error"),
	() -> System.out.println("Completed")
);
````

Output
````
Completed
````


BehaviorSubject를 생성시에 초기값을 넣어주면 다른 값이 Subject로 푸시되기 전까지는 초기값이 subscribe할 때에 전달된다.

````java
BehaviorSubject<Integer> s = BehaviorSubject.create(0);
s.subscribe(v -> System.out.println(v));
s.onNext(1);
````



### AsyncSubject
`AsyncSubject`도 마찬가지로 마지막 값을 캐싱한다.
`BehaviorSubject`와의 차이점은 시퀀스가 완료되기 전까지는 값을 방출하지 않는다는 것이다.
`onComplete()`를 호출하지 않으면 값을 방출하지 않으며 `onError()`가 호출되면 그 이전의 값은 지워지고 Error 상태만이 남는다.

````java
AsyncSubject<Integer> s = AsyncSubject.create();
s.subscribe(v -> System.out.println(v));
s.onNext(0);
s.onNext(1);
s.onNext(2);
s.onCompleted();
````

Output
````
2
````


## 암시적인 규칙들
Rx는 코드에서는 명확히 들어나지 않는 몇가지 규칙들이 있다.
가장 중요한 것은 종료 이벤트(onError, onComplete) 이후에는 어떠한 이벤트도 방출되지 않는다는 것이다.
구현된 subject들은 이 사항을 지키고 있으며 `subscribe` 메서드는 이 규칙에 위반되는 것을 방지한다.

````java
Subject<Integer, Integer> s = ReplaySubject.create();
s.subscribe(v -> System.out.println(v));
s.onNext(0);
s.onCompleted();
s.onNext(1);
s.onNext(2);
````

Output
````
0
````

이와 같은 안전장치는 Rx의 모든 구현체에서 보장되는 것이 아니다.
따라서 이 규칙을 지키는 것이 가장 좋으며 그렇지 않을 경우 비정상적인 작업으로 이어질 수 있다.