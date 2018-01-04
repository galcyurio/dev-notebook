# Difference between Kotlin and Java 

- 매개변수를 쓸 때 이름이 먼저 오고 타입이 온다.
- main 함수가 class 에 들어가지 않아도 된다.
- Array 또한 class 이다. Array 를 위한 특별한 문법은 존재하지 않는다.
- println() 함수와 같이 기존 java library 를 대체하는 kotlin standard library 가 존재한다.
- ;(세미콜론) 을 쓰지 않아도 된다.

- 함수 return type 은 뒤에 쓰거나 생략 가능하다.  
  생략하는 경우에는 expression body 가 존재해야 한다.
- 조건연산자(a > b ? a : b) 는 존재하지 않으며 if 문을 통해 대신할 수 있다.  
  if 문은 kotlin 에서 statement 뿐만 아니라 expression 도 가능하다.  
  expression 으로 쓰는 경우에는 else 를 생략할 수 없다.
    ````kotlin
    if(a > b) a else b
    ````
- Switch 문은 case 문을 통해 대신할 수 있다. 아래와 같이 조건연산자도 대신할 수 있다.
    ````kotlin
    val max = when(a > b) {
      true -> a
      false -> b
    }
    ````

- groovy 나 ruby와 다르게 return type 이 있으면 return 문을 명시적으로 써야한다.

- immutable 은 val, mutable 은 var 키워드로 변수를 선언한다.
- 변수 type 은 생략할 수 있다.
- 변수 선언 시에 초기화를 해주지 않으면 변수 type 을 생략할 수 없다.
- String template 을 사용 가능하다.
- class 선언이 val, var, 생성자와 연결되어 setter, getter 선언없이 짧은 코드로 빠르게 선언가능하다.

