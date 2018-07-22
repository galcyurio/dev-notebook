# 자바로 안드로이드에서 살아남기

안드로이드에서 자바는 버전7 정도에서 멈췄다고 생각하면 된다.
minSdkVersion을 높이면 자바8의 기능들을 대부분 쓸 수 있지만 그렇다고 대다수의 유저를 포기할 수는 없다.

# javax.time 패키지 (JSR 310)
이 문제는 kotlin을 쓰더라도 피할 수 없다.
시간이 굉장히 중요하다면 ThreeTenABP를 고려해보아야 한다.

# Stream
RxJava를 쓰면 된다.

# Lambda, Method reference, default and static interface method
이전까지는 RetroLambda 또는 Jack 툴체인을 사용했지만 Android Studio 3.0 부터는 기본 툴체인에서 모두 지원한다.
사용 방법은 모듈의 `build.gradle`에 다음을 추가하면 된다.

````
android {
  // ....

  compileOptions {
    sourceCompatibility JavaVersion.VERSION_1_8
    targetCompatibility JavaVersion.VERSION_1_8
  }
}
````


# Nullability 문제
Guava의 Optional을 이용한다. 
아쉬운 점은 java8 Optional의 고차함수들을 대부분 지원하지 않고 map 하나만 지원한다.
단순히 null 대신에 Optional을 씀으로써 null을 경계하는 정도로만 쓸 수 있다.

RxJava2의 Maybe를 사용할 수도 있다.


# Mutability 문제
Guava의 ImmutableCollection을 이용한다.
add 또는 remove 관련 메서드들은 @Deprecated 주석이 붙어있고 호출하면 runtime에 exception이 터진다.


# 참고문서
- https://developer.android.com/guide/platform/j8-jack?hl=ko
- https://youtu.be/A2LukgT2mKc
- https://developer.android.com/studio/write/java8-support?utm_source=android-studio