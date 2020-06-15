# 코루틴은 어떻게 동작하나요?

코루틴이 어떻게 동작하는지 알아보기 전에 2가지 코딩 스타일을 살펴봅시다.

### Direct style
```kotlin
fun postItem(item: Item) {
    val token = requestToken()
 
    // Continuation
    val post = createPost(token, item);
    processPost(post)
}
```

### Continuation Passing Style
```kotlin
fun postItem(item: Item) {
    requestToken { token ->
        // Continuation
        createPost(token, item) { post ->
            processPost(post)
        }    
    }
}
```

> ## Continuation이 무엇인가요?
>
> 먼저 위의 Direct style을 살펴봅시다. 
> `postItem()` 함수는 `requestToken()` 함수를 호출합니다.
> 그리고 `requestToken()` 함수가 반환한 값으로 다른 작업들을 수행합니다.
> 
> 이 상황을 조금 더 자세하게 설명해보겠습니다.
> `postItem()` 함수에서 `requestToken()` 함수를 호출하며 제어 흐름(control flow)을 넘길 때 다시 돌아올 때(return)를 위해서 어디로 돌아와야 하는지 콜 스택에 적어둡니다.
> 그리고 `requestToken()` 함수에서 다시 돌아올 때(return) 콜 스택을 참조하여 `postItem()`으로 제어 흐름이 넘어옵니다.
> 그리고 `requestToken()` 함수에서 반환한 값으로 다른 작업들을 수행합니다.
>
> Continuation Passing style(CPS)은 `requestToken()`의 반환값으로 수행하는 다른 작업들을 `requestToken()` 함수의 매개변수로 넘겨주는 형태를 말합니다.
> 위의 코드와 같이 함수로 묶어서 넘길 수 있습니다.
> CPS에서는 모든 함수 호출이 tail call 이라서 컴파일러가 tail call optimization(TCO)을 수행할 수 있습니다.
> 그리고 CPS와 TCO는 함수의 return이 필요없어지고 따라서 콜 스택이 필요없어집니다.
> 
> **TL;DR** Continuation Passing Style = Callback

코루틴은 우리가 continuation passing style을 쓸 필요 없이 direct style의 코드를 작성할 수 있게 해줍니다.
코루틴을 통해 direct style의 코드를 작성하고 바이트코드를 디컴파일해보면 다음과 같습니다.

```kotlin
suspend fun requestToken(): Token = Token()

suspend fun createPost(token: Token, item: Item): Post = Post()

fun processPost(post: Post) {
    println("processPost")
}

suspend fun postItem(item: Item) {
    val token = requestToken()
    val post = createPost(token, item)
    processPost(post)
}
```

```java
@Nullable
public static final Object postItem(@NotNull Item item, @NotNull Continuation $completion) {
    Object $continuation;
    label27: {
        if ($completion instanceof <undefinedtype>) {
        $continuation = (<undefinedtype>)$completion;
        if ((((<undefinedtype>)$continuation).label & Integer.MIN_VALUE) != 0) {
            ((<undefinedtype>)$continuation).label -= Integer.MIN_VALUE;
            break label27;
        }
        }

        $continuation = new ContinuationImpl($completion) {
        // $FF: synthetic field
        Object result;
        int label;
        Object L$0;
        Object L$1;

        @Nullable
        public final Object invokeSuspend(@NotNull Object $result) {
            this.result = $result;
            this.label |= Integer.MIN_VALUE;
            return MainKt.postItem((Item)null, this);
        }
        };
    }

    Object var10000;
    label22: {
        Object $result = ((<undefinedtype>)$continuation).result;
        Object var6 = IntrinsicsKt.getCOROUTINE_SUSPENDED();
        Token token;
        switch(((<undefinedtype>)$continuation).label) {
        case 0:
        ResultKt.throwOnFailure($result);
        ((<undefinedtype>)$continuation).L$0 = item;
        ((<undefinedtype>)$continuation).label = 1;
        var10000 = requestToken((Continuation)$continuation);
        if (var10000 == var6) {
            return var6;
        }
        break;
        case 1:
        item = (Item)((<undefinedtype>)$continuation).L$0;
        ResultKt.throwOnFailure($result);
        var10000 = $result;
        break;
        case 2:
        token = (Token)((<undefinedtype>)$continuation).L$1;
        item = (Item)((<undefinedtype>)$continuation).L$0;
        ResultKt.throwOnFailure($result);
        var10000 = $result;
        break label22;
        default:
        throw new IllegalStateException("call to 'resume' before 'invoke' with coroutine");
        }

        token = (Token)var10000;
        ((<undefinedtype>)$continuation).L$0 = item;
        ((<undefinedtype>)$continuation).L$1 = token;
        ((<undefinedtype>)$continuation).label = 2;
        var10000 = createPost(token, item, (Continuation)$continuation);
        if (var10000 == var6) {
        return var6;
        }
    }

    Post post = (Post)var10000;
    processPost(post);
    return Unit.INSTANCE;
}

@Nullable
public static final Object requestToken(@NotNull Continuation $completion) {
    return new Token();
}

@Nullable
public static final Object createPost(@NotNull Token token, @NotNull Item item, @NotNull Continuation $completion) {
    return new Post();
}

public static final void processPost(@NotNull Post post) {
    Intrinsics.checkParameterIsNotNull(post, "post");
    String var1 = "processPost";
    boolean var2 = false;
    System.out.println(var1);
}
```

자바 코드가 조금 복잡하지만 `postItem()` 메서드의 `$continuation` 변수를 중심으로 살펴보면 Continuation의 label 변수에 수를 저장하고 해당 label에 따라서 수행하는 작업이 다르다는 것을 알 수 있습니다.
또한 Continuation의 `L$0`, `L$1`과 같은 변수에 우리가 매개변수로 선언했던 Token, Item과 같은 값을 저장하거나 빼서 쓰는 것을 확인할 수 있습니다.

이를 통해 Direct style의 코틀린 코드가 Continuation passing style의 자바 코드로 바뀌고 거기서 핵심은 Continuation 이라는 걸 알 수 있습니다.

## 참조문서
- [KotlinConf 2017 - Deep Dive into Coroutines on JVM by Roman Elizarov](https://youtu.be/YrrUCSi72E8)
- [Wikipedia - Continuation](https://en.wikipedia.org/wiki/Continuation)
- [코루틴과 컨티뉴에이션](http://enshahar.com/seeds/coroutine/continuation/2017/11/17/coroutine-continuation-%EB%B3%B5%EC%82%AC%EB%B3%B8/)
- [Haskell/Continuation passing style](https://en.wikibooks.org/wiki/Haskell/Continuation_passing_style)