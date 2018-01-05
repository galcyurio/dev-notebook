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

- groovy 나 ruby와 다르게 function 에 return type 이 있으면 return 문을 명시적으로 써야한다.
- {} block 에서는 마지막 줄이 return 키워드 없이 return 된다.

- immutable 은 val, mutable 은 var 키워드로 변수를 선언한다.
- 변수 type 은 생략할 수 있다.
- 변수 선언 시에 초기화를 해주지 않으면 변수 type 을 생략할 수 없다.
- String template 을 사용 가능하다.
- class 선언이 val, var, 생성자와 연결되어 setter, getter 선언없이 짧은 코드로 빠르게 선언가능하다.

- enum 에서 abstract function 사용하여 각 요소마다 anonymous class 와 function 구현체를 선언할 수 있다.

- ... 대신에 until 을 사용하여 마지막 요소를 제외한다.

- 예외 처리시에 `throws` 를 쓰지 않는다.
- checked exception 과 unchecked exception 으로 나누지 않는다.
- 대부분의 경우 exception 을 다루지 않는다.
- try 문은 expression 이다. 따라서 값을 반환한다.

### 2장 요약
- The `fun` keyword is used to declare a function.  
  The `val` and `var` keywords declare read-only and mutable variables, respectively.
- String templates help you avoid noisy string concatenation.  
  Prefix a variable name with `$` or surround an expression with `${ }` to have its value injected into the string.
- Value-object classes are expressed in a concise way in Kotlin.
- The familiar `if` is now an expression with a return value.
- The `when` expression is analogous to `switch` in Java but is more powerful.
- You don’t have to cast a variable explicitly after checking that it has a certain type: 
  the compiler casts it for you automatically using a smart cast.
- The `for`, `while`, and `do-while` loops are similar to their counterparts in Java, 
  but the for loop is now more convenient, 
  especially when you need to iterate over a map or a collection with an index.
- The concise syntax `1..5` creates a range. 
  Ranges and progressions allow Kotlin to use a uniform syntax and set of abstractions in for loops 
  and also work with the `in` and `!in` operators that check whether a value - belongs to a range.
- Exception handling in Kotlin is very similar to that in Java, 
  except that Kotlin doesn’t require you to declare the exceptions that can be thrown by a function.