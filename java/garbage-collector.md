# `Garbage Collector`
- original references
  - [Naver D2](http://d2.naver.com/helloworld/329631)

Java의 가비지 컬렉터(Garbage Collector)는 그 동작 방식에 따라 매우 다양한 종류가 있지만 공통적으로 크게 다음 2가지 작업을 수행한다고 볼 수 있습니다.
1. 힙(heap) 내의 객체 중에서 가비지(garbage)를 찾아낸다.
1. 찾아낸 가비지를 처리해서 힙의 메모리를 회수한다.

## GC와 Reachability
Java GC는 객체가 가비지인지 판별하기 위해서 reachability라는 개념을 사용한다. 어떤 객체에 유효한 참조가 있으면 `reachable`로, 없으면 `unreachable`로 구별하고, unreachable 객체를 가비지로 간주해 GC를 수행한다.

한 객체는 여러 다른 객체를 참조하고, 참조된 다른 객체들도 마찬가지로 또 다른 객체들을 참조할 수 있으므로 객체들은 참조 사슬을 이룬다. 이런 상황에서 유효한 참조 여부를 파악하려면 `항상 유효한 최초의 참조`가 있어야 하는데 이를 객체 참조의 `root set`이라고 한다.

## Soft, Weak, Phantom Reference
java.lang.ref는 soft reference와 weak reference, phantom reference를 클래스 형태로 제공한다. 예를 들면, java.lang.ref.WeakReference 클래스는 참조 대상인 객체를 캡슐화(encapsulate)한 WeakReference 객체를 생성한다. 이렇게 생성된 WeakReference 객체는 다른 객체와 달리 Java GC가 특별하게 취급한다(이에 대한 내용은 뒤에서 다룬다). 캡슐화된 내부 객체는 weak reference에 의해 참조된다.

Java 스펙에서는 SoftReference, WeakReference, PhantomReference 3가지 클래스에 의해 생성된 객체를 `reference object`라고 부른다. 이는 흔히 strong reference로 표현되는 일반적인 참조나 다른 클래스의 객체와는 달리 3가지 Reference 클래스의 객체에 대해서만 사용하는 용어이다. 또한 이들 reference object에 의해 참조된 객체는 `referent`라고 부른다.

## Reference와 Reachability
앞에서 설명한 것처럼, 원래 GC 대상 여부는 reachable인가 unreachable인가로만 구분하였고 이를 사용자 코드에서는 관여할 수 없었다. 그러나 java.lang.ref 패키지를 이용하여 reachable 객체들을 strongly reachable, softly reachable, weakly reachable, phantomly reachable로 더 자세히 구별하여 GC 때의 동작을 다르게 지정할 수 있게 되었다. 다시 말해, GC 대상 여부를 판별하는 부분에 사용자 코드가 개입할 수 있게 되었다.

GC가 동작할 때, unreachable 객체뿐만 아니라 weakly reachable 객체도 가비지 객체로 간주되어 메모리에서 회수된다.

위 그림에서 WeakReference 객체 자체는 weakly reachable 객체가 아니라 strongly reachable 객체이다. 또한, 그림에서 A로 표시한 객체와 같이 WeakReference에 의해 참조되고 있으면서 동시에 root set에서 시작한 참조 사슬에 포함되어 있는 경우에는 weakly reachable 객체가 아니라 strongly reachable 객체이다.

GC가 동작하여 어떤 객체를 weakly reachable 객체로 판명하면, GC는 WeakReference 객체에 있는 weakly reachable 객체에 대한 참조를 null로 설정한다. 이에 따라 weakly reachable 객체는 unreachable 객체와 마찬가지 상태가 되고, 가비지로 판명된 다른 객체들과 함께 메모리 회수 대상이 된다.

## Strengths of Reachability
앞에서 설명한 것처럼 reachability는 총 5종류가 있고 이는 GC가 객체를 처리하는 기준이 된다. Java 스펙에서는 이들 5종류의 reachability를 `Strengths of Reachability`라 부른다. 

- `strongly reachable`: root set으로부터 시작해서 어떤 reference object도 중간에 끼지 않은 상태로 참조 가능한 객체, 다시 말해, 객체까지 도달하는 여러 참조 사슬 중 reference object가 없는 사슬이 하나라도 있는 객체
- `softly reachable`: strongly reachable 객체가 아닌 객체 중에서 weak reference, phantom reference 없이 soft reference만 통과하는 참조 사슬이 하나라도 있는 객체
- `weakly reachable`: strongly reachable 객체도 softly reachable 객체도 아닌 객체 중에서, phantom reference 없이 weak reference만 통과하는 참조 사슬이 하나라도 있는 객체
- `phantomly reachable`: strongly reachable 객체, softly reachable 객체, weakly reachable 객체 모두 해당되지 않는 객체. 이 객체는 파이널라이즈(finalize)되었지만 아직 메모리가 회수되지 않은 상태이다.
- `unreachable`: root set으로부터 시작되는 참조 사슬로 참조되지 않는 객체

## Softly Reachable과 SoftReference
softly reachable 객체, 즉 strong reachable이 아니면서 오직 SoftReferencce 객체로만 참조된 객체는 힙에 남아 있는 메모리의 크기와 해당 객체의 사용 빈도에 따라 GC 여부가 결정된다.
그래서 softly reachable 객체는 weakly reachable 객체와는 달리 GC가 동작할 때마다 회수되지 않으며 자주 사용될수록 더 오래 살아남게 된다.
> softly reachable 객체의 GC 여부는 위 옵션의 에 설정한 숫자에 따라 다음 수식에 의해 결정된다.
> - (마지막 strong reference가 GC된 때로부터 지금까지의 시간) > (옵션 설정값 N) * (힙에 남아있는 메모리 크기)
어떤 객체가 사용된다는 것은 strong reference에 의해 참조되는 것이므로 위 수식의 좌변은 해당 객체가 얼마나 자주 사용되는지를 의미한다. 옵션 설정값이 1000이고 남아 있는 메모리가 100MB이면, 수식의 우변은 1,000ms/MB * 100MB = 100,000ms = 100sec, 즉 100초가 된다(옵션 이름 마지막이 MSPerMB로 끝나므로 옵션 설정값의 단위는 ms/MB임을 알 수 있다). 따라서 softly reachable 객체가 100초 이상 사용되지 않으면 GC에 의해 회수 대상이 된다. 힙에 남아있는 메모리가 작을수록 우변의 값이 작아지므로, 힙이 거의 소진되면 대부분의 softly reachable 객체는 모두 메모리에서 회수되어 OutOfMemoryError를 막게 될 것이다.

softly reachable 객체를 GC하기로 결정되면 앞서 설명한 WeakReference 경우와 마찬가지로 참조 사슬에 존재하는 SoftReference 객체 내의 softly reachable 객체에 대한 참조가 null로 설정되며, 이후 이 softly reachable객체는 unreachable 객체와 마찬가지가 되어 GC의해 메모리가 회수된다.

## Weakly Reachable과 WeakReference
weakly reachable 객체는 특별한 정책에 의해 GC 여부가 결정되는 softly reachable 객체와는 달리 GC를 수행할 때마다 회수 대상이 된다. 
앞서 설명한 것처럼 WeakReference 내의 참조가 null로 설정되고 weakly reachable 객체는 unreachable 객체와 마찬가지 상태가 되어 GC에 의해 메모리가 회수된다. 
그러나 GC가 실제로 언제 객체를 회수할지는 GC 알고리즘에 따라 모두 다르므로, GC가 수행될 때마다 반드시 메모리까지 회수된다고 보장하지는 않는다. 
이는 softly reachable 객체는 물론 unreachable 객체도 마찬가지이다. GC가 GC 대상인 객체를 찾는 작업과 GC 대상인 객체를 처리하여 메모리를 회수하는 작업은 즉각적인 연속 작업이 아니며, GC 대상 객체의 메모리를 한 번에 모두 회수하지도 않는다.

LRU 캐시와 같은 애플리케이션에서는 softly reachable 객체보다는 weakly reachable 객체가 유리하므로 LRU 캐시를 구현할 때에는 대체로 WeakReference를 사용한다. 
softly reachable 객체는 힙에 남아 있는 메모리가 많을수록 회수 가능성이 낮기 때문에, 다른 비즈니스 로직 객체들을 위해 어느 정도 비워두어야 할 힙 공간이 softly reachable 객체에 의해 일정 부분 점유된다. 
따라서 전체 메모리 사용량이 높아지고 GC가 더 자주 일어나며 GC에 걸리는 시간도 상대적으로 길어지는 문제가 있다.