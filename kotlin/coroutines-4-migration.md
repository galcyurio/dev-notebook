# 코루틴을 기존 코드들과 같이 사용할 수 있나요?

> 여기서 말하는 **기존 코드**란 코루틴을 적용하지 않은 비동기 프로그래밍 코드들을 의미합니다. 
> 예를 들어 callback 함수 또는 Future, RxJava, 쓰레드 등을 사용한 코드를 말합니다.

먼저 콜백 함수를 사용하는 2가지 경우를 확인해보겠습니다.

## 1. 함수가 콜백함수를 등록할 수 있는 Future 타입을 반환하는 경우
> 이 글에서의 `Future 타입`은 편의상 CompletableFuture와 같은 Future 타입을 포함해서 RxJava의 `Observable`이나 Retrofit의 `Call`과 같은 타입을 포함합니다.

코루틴을 적용하지 않았을 때의 코드를 먼저 살펴보겠습니다.
GitHub의 API 서버에서 유저목록을 가져와서 출력하는 간단한 코드입니다.
여기서는 OkHttp의 Call 클래스를 에제로 사용했습니다.

```kotlin
fun requestUsers(): Call {
    val client = OkHttpClient()
    val request = Request.Builder()
        .get()
        .url("https://api.github.com/users")
        .build()
    return client.newCall(request)
}

fun main() {
    requestUsers().enqueue(object : Callback {
        override fun onFailure(call: Call, e: IOException) {
            // 예외 처리
        }

        override fun onResponse(call: Call, response: Response) {
            if (!response.isSuccessful) {
                // 요청 실패 처리
            }

            val body = response.body?.string()
            println(body) // 응답 처리
        }
    })
    // 참고: OkHttp 쓰레드 풀이 남아서 자동 종료 되지 않음
}
```

위와 같이 Future 타입이 반환되는 경우에는 `suspendCoroutine()` 함수를 이용해 해당 Future 타입의 확장함수로 `await()` 함수를 만들어줄 수 있습니다.

> suspendCoroutine() 함수는 현재 코루틴을 일시 중단(suspend)하고 `Continuation` 객체 인스턴스를 통해 다시 재개(resume)할 수 있도록 해줍니다.

```kotlin
suspend fun Call.await(): String? = suspendCoroutine { continuation ->
    enqueue(object : Callback {
        override fun onFailure(call: Call, e: IOException) {
            continuation.resume(null)
        }

        override fun onResponse(call: Call, response: Response) {
            val body = response.body?.string()
            continuation.resume(body)
        }
    })
}
```

> `continuation.resumeWithException()` 함수를 사용할 수도 있습니다.
> 취소와 예외처리에 관한 이야기까지 꺼내야해서 여기서는 사용하지 않았습니다.

이렇게 Future 타입에 대해 `await()` 확장 함수를 추가해주면 `requestUsers()` 함수를 호출하는 부분의 코드는 다음과 같이 콜백함수를 사용하지 않아도 됩니다.

```kotlin
// 프로덕션 코드에서 runBlocking 사용하지 말 것
fun main() = runBlocking {
    val body = requestUsers().await()
    if (body == null) {
        // 요청 실패 처리
    } else {
        // 성공 처리
        println(body)
    }
}
```

## 2. 함수의 매개변수로 콜백함수를 받는 경우

TODO

## 3. suspend 함수를 매개변수로 받아서 Future 타입을 반환하는 경우

TODO