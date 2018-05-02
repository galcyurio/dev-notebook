## Kotlin 의 also, apply, run, let
builder pattern 과 같이 chain 방식으로 코딩을 가능하게 해준다.

- also : it -> this
- apply : this -> this
- run : this -> return
- let : it -> return

## measureTimeXXX
시간 측정을 가능하게 해준다.

````kotlin
val time = measureTimeMillis {
   // do something
}
println("$time")
````

## 숫자에 _(underscore) 붙이기
숫자 사이에 `_`를 붙임으로써 숫자 가독성을 높일 수 있다.
````kotlin
val int = 10_000_000_000
````

## List.plus 오버로딩
````kotlin
val list = listOf(1, 2, 3, 4, 5) + 6 + 7
println(list)
// [1, 2, 3, 4, 5, 6, 7]
````

## Map, Pair 오버로딩
````kotlin
val map = mutableMapOf(
    1 to "one",
    2 to "two",
    3 to "three"
)
map[4] = "four"
map[5] = "five"

println(map)
// {1=one, 2=two, 3=three, 4=four, 5=five}
````

## import 이름 바꾸기
````kotlin
import java.util.stream.IntStream as IStream
import java.util.stream.LongStream as LStream

fun main(args: Array<String>) {
    IStream.of(1, 2, 3, 4, 5)
    LStream.of(1, 2, 3, 4, 5)
}
````


## kotlin 으로 작성된 언어를 java 코드로 보기
`Show Kotlin Bytecode` -> Decompile 클릭