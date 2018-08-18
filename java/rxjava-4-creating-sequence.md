# 시퀀스 만들기
이전 예제에서 `Subject`에 직접 값을 넣고 시퀀스를 만들었습니다.
우리는 이 시퀀스를 사용하여 몇 가지 주요 개념과 가장 중요한 Rx 방법인 `subscribe`을 시연했습니다.
대부분의 경우에 `Subject`를 이용하는 것이 새로운 `Observable`을 만드는 데 가장 좋은 방법은 아닙니다.
이제 observable 시퀀스를 만드는 더 깔끔한 방법을 보게 될 것입니다.

## 간단한 factory methods

### Observable.just
`just`메서드는 제공되는 값들의 시퀀스를 생성하여 `Observable`을 생성합니다.

````java
Observable<String> values = Observable.just("one", "two", "three");
Subscription subscription = values.subscribe(
    v -> System.out.println("Received: " + v),
    e -> System.out.println("Error: " + e),
    () -> System.out.println("Completed")
);	
````

Output
````
Received: one
Received: two
Received: three
Completed
````


### Observable.empty
이 observable은 오직 `onCompleted`만 호출하고 아무런 값도 방출하지 않습니다.
````java
Observable<String> values = Observable.empty();
Subscription subscription = values.subscribe(
    v -> System.out.println("Received: " + v),
    e -> System.out.println("Error: " + e),
    () -> System.out.println("Completed")
);
````

Output
````
Completed
````


### Observable.never

이 observable은 아무것도 방출하지 않습니다.
````java
Observable<String> values = Observable.never();
Subscription subscription = values.subscribe(
    v -> System.out.println("Received: " + v),
    e -> System.out.println("Error: " + e),
    () -> System.out.println("Completed")
);
````

위 코드는 아무것도 출력하지 않습니다.
하지만 프로그램이 블럭되는 것을 의미하는건 아닙니다.
실제로는 즉시 종료됩니다.


### Observable.error
이 observable은 error 이벤트와 complete 이벤트만 방출합니다.

````java
Observable<String> values = Observable.error(new Exception("Oops"));
Subscription subscription = values.subscribe(
    v -> System.out.println("Received: " + v),
    e -> System.out.println("Error: " + e),
    () -> System.out.println("Completed")
);
````

Output
````
Error: java.lang.Exception: Oops
````



### Observable.defer
observer가 구독하기 전에는 `Observable`을 만들지 않고 각각의 observer가 구독할 때 Observable을 만든다.
이게 어디에 쓰이는지 살펴보자.
현재 시간을 방출하고 종료되는 observable을 만든다고 생각해보자. 
하나의 value만 방출하면 되니 `just`를 쓰면 될 것 같다.

````java
Observable<Long> now = Observable.just(System.currentTimeMillis());

now.subscribe(System.out::println);
Thread.sleep(1000);
now.subscribe(System.out::println);
````

Output

````
1431443908375
1431443908375
````

하지만 실제로는 제대로 동작하지 않는다.
Output을 보면 둘 모두 같은 시간을 출력한 것을 볼 수 있다.
그 이유는 `just`가 호출될 때 시간 값이 단 한 번만 넘어가기 때문이다.
우리가 원하는 시간은 구독자가 구독하는 그 때의 시간이다.

`defer`는 function을 하나 받아서 `Observable`이 생성될 때 호출한 다음 `Observable`을 반환한다.
`defer`로 넘어가는 function에서 반환되는 `Observable`은 `defer`를 통해 반환되는 `Observable`과 동일하다.
여기서 중요한 점은 이 함수는 모든 새로운 구독들에 대해 각각 실행된다는 점이다.

````java
Observable<Long> now = Observable.defer(() ->
		Observable.just(System.currentTimeMillis()));

now.subscribe(System.out::println);
Thread.sleep(1000);
now.subscribe(System.out::println);
````


Output

````
1431444107854
1431444108858
````


### Observable.create
`create`는 `Observable`을 만들 때 상당히 강력한 함수입니다.
메서드 시그니쳐는 다음과 같습니다.

````java
static <T> Observable<T> create(Observable.OnSubscribe<T> f)
````

`Observable.OnSubscribe<T>`는 보기보다 간단합니다.
`T` 타입을 위한 `Subscriber<T>`를 받는 함수입니다.
그 안에 우리는 수동으로 구독자에게 방출되는 이벤트를 결정할 수 있습니다.

````java
Observable<String> values = Observable.create(o -> {
	o.onNext("Hello");
	o.onCompleted();
});
Subscription subscription = values.subscribe(
    v -> System.out.println("Received: " + v),
    e -> System.out.println("Error: " + e),
    () -> System.out.println("Completed")
);
````


Output

````
Received: Hello
Completed
````

누군가가 observable을 구독하면 해당 `Subscriber` 인스턴스가 함수로 전달된다.
코드가 실행되면 값들은 subscriber로 푸시되어야 한다.
그리고 시퀀스 완료 이벤트를 일으키려면 직접 `onCompleted`를 호출해야 한다.

이 메서드는 기존의 다른 편리한 메서드를 통해 custom observable을 만들 수 없는 경우에 쓰일 수 있습니다.
코드는 마치 우리가 `Subject`를 만들고 값들을 푸시하던 것과 비슷하게 보일 수 있지만 몇 가지 중요한 차이점들이 있습니다.

가장 먼저, 이벤트의 소스는 깔끔하게 캡슐화되고 관련없는 코드와 분리됩니다.
두번째로, `Subject`는 당신이 상태를 관리하며 누구나 인스턴스에 접근해서 값을 푸시하고 시퀀스의 순서를 변경할수 있어서 명확하지 않다는 위험성을 가지고 있다.
또다른 중요한 차이점은 observer가 구독을 할 때 코드가 지연되어 실행된다는 것이다.
위의 예제를 보면 observable이 생성될 때 (구독자가 아직 없기 때문에) 코드가 실행되지 않지만 `subscribe`가 호출 될 떄마다 코드가 실행됩니다.
