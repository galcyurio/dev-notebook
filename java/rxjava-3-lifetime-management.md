# Lifetime management
Rx의 개념은 시퀀스가 값을 내보내거나 종료할 때를 알 수 없지만 값을 받아들이기를 시작하거나 멈추는 것들에 대한 제어를 할 수 있다는 것이다.
구독은 시퀀스의 마지막에 해방하려는 자원에 연결 될 수도 있다.
Rx는 구독을 통해 이를 제어할 수 있도록 한다.

## Subscribing (구독하기)
`Observable.subscribe`에는 몇 가지 오버로딩된 메서드가 있다.

````java
Subscription 	subscribe()
Subscription 	subscribe(Action1<? super T> onNext)
Subscription 	subscribe(Action1<? super T> onNext, Action1<java.lang.Throwable> onError)
Subscription 	subscribe(Action1<? super T> onNext, Action1<java.lang.Throwable> onError, Action0 onComplete)
Subscription 	subscribe(Observer<? super T> observer)
Subscription 	subscribe(Subscriber<? super T> subscriber)
````

`subscribe()`는 이벤트를 소비하지만 아무런 작업도 수행하지 않는다.
다른 오버로딩된 메서드들은 넘겨받는 하나 이상의 `Action` 함수와 함께 `Subscriber`를 만든다.
어떠한 함수도 넘기지 않으면 이벤트는 사실상 무시된다.

다음 예제는 실패한 시퀀스에 대한 오류를 처리하는 코드다.

````java
Subject<Integer, Integer> s = ReplaySubject.create();
s.subscribe(
	v -> System.out.println(v),
	e -> System.err.println(e));
s.onNext(0);
s.onError(new Exception("Oops"));
````


Output
````
0
java.lang.Exception: Oops
````

만약 에러 핸들링을 위한 함수를 제공하지 않으면 `s.onError`를 호출한 측, 즉 제공하는 쪽에서 `OnErrorNotImplementedException`이 일어난다.
여기서는 제공자와 소비자가 같이 있으니 전통적인 try-catch를 쓸 수도 있다. 하지만 구획화된 시스템에서 대부분 생산자와 구독자는 다른 위치에 있다.
소비자가 구독할 오류에 대해서 처리해주지 않으면 소비자는 오류가 발생하고 시퀀스가 종료되었음을 알 수 없다.

## Unsubscribing (구독 해제하기)
우리는 시퀀스가 종료되기 전에 값들을 받는 것을 중단할 수도 있다.
모든 `subscribe` 메서드들은 2가지 메서드를 가지는 인터페이스인 `Subscription` 인스턴스를 반환한다.

````java
boolean isUnsubscribed()
void unsubscribe()
````

`unsubscribe`를 호출하면 observer에서 값을 push하는 이벤트가 중단된다.

````java
Subject<Integer, Integer>  values = ReplaySubject.create();
Subscription subscription = values.subscribe(
    v -> System.out.println(v),
    e -> System.err.println(e),
    () -> System.out.println("Done")
);
values.onNext(0);
values.onNext(1);
subscription.unsubscribe();
values.onNext(2);
````

Output
````
0
1
````

여러개의 observer가 같은 observable을 구독하고 있다가 하나가 구독을 취소해도 다른 observer가 값을 받는 것에 대해 방해하지 않는다.

````java
Subject<Integer, Integer>  values = ReplaySubject.create();
Subscription subscription1 = values.subscribe(
    v -> System.out.println("First: " + v)
);
Subscription subscription2 = values.subscribe(
	v -> System.out.println("Second: " + v)
);
values.onNext(0);
values.onNext(1);
subscription1.unsubscribe();
System.out.println("Unsubscribed first");
values.onNext(2);
````

Output
````
First: 0
Second: 0
First: 1
Second: 1
Unsubscribed first
Second: 2
````

## onError and onCompleted
`onError`와 `onCompleted`는 시퀀스의 종료를 의미한다.
두 이벤트가 일어나면 Rx의 규약에 따라 observable은 어떠한 값도 방출하지 않는다.

````java
Subject<Integer, Integer>  values = ReplaySubject.create();
Subscription subscription1 = values.subscribe(
    v -> System.out.println("First: " + v),
    e -> System.out.println("First: " + e),
    () -> System.out.println("Completed")
);
values.onNext(0);
values.onNext(1);
values.onCompleted();
values.onNext(2);
````

Output
````
First: 0
First: 1
Completed
````


## Freeing resources (자원 해방하기)
`Subscription`은 사용하는 자원과 결합되어 있다.
그러므로, 반드시 구독을 처리해주어야 한다.
`Subscriptions` factory를 이용해 `Subscription`과 필요한 자원들 사이에 바인딩을 만들어줄 수 있다.

````java
Subscription s = Subscriptions.create(() -> System.out.println("Clean"));
s.unsubscribe();
````

Output
````
Clean
````

`Subscriptions.create`는 자원이 해방될 때 수행될 `Action`을 받는다.
또한 시퀀스를 만들 때 일반적인 action에 대한 쉬운 방법이 있다.

- `Subscriptions.empty()` dispose될 때 아무것도 하지 않는 `Subscription`을 반환한다. 이 방법은 `Subscription` 인스턴스를 반환해야 하지만 실제로는 해방시킬 자원이 없는 경우에 적합하다.
- `Subscriptions.from(Subscription... subscriptions)`는 한꺼번에 여러개를 dispose할 수 있는 `Subscription`을 반환한다.
- `Subscriptions.unsubscribed()`는 이미 dispose된 `Subscription`을 반환한다.

이미 여러개의 `Subscription` 구현체들이 있다.
- BooleanSubscription
- CompositeSubscription
- MultipleAssignmentSubscription
- RefCountSubscription
- SafeSubscriber
- Scheduler.Worker
- SerializedSubscriber
- SerialSubscription
- Subscriber
- TestSubscriber

흥미로운 점은 `Subscriber`는 `Subscription`도 구현하고 있다는 점이다. 
따라서 `Subscriber`를 통해 subscription을 종료할 수 있다는 것을 의미한다.