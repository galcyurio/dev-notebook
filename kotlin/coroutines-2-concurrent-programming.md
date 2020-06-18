# 코루틴으로 동시 프로그래밍을 하려면 어떻게 해야 하나요?

코루틴에서 동시 프로그래밍을 하는 방법을 설명하기 전에 먼저 Structured concurrency가 무엇인지 코루틴에서는 무슨 문제가 있었는지 알아봅시다.

코루틴에서는 동시 프로그래밍을 위해 Structured concurrency를 도입했습니다.

> 오늘 kotlinx.coroutines 라이브러리 0.26.0 버전이 출시되었고 코루틴에 structured concurrency가 도입되었습니다. 이는 단순한 기능의 추가가 아니라 관념의 변화가 너무나 커서 이렇게 글을 쓰고 있습니다.
> 
> 2017년에 코루틴을 처음 소개할 당시 쓰레드의 동시성을 생각하는 프로그래머들에게 코루틴의 개념을 설명하기란 힘들었습니다. 그래서 우리의 주요 비유와 모토는 "코루틴은 가벼운 쓰레드"였습니다. 그리고 학습 곡선을 낮추기 위해 주요 API는 쓰레드 API와 유사하게 설계되었습니다. 이러한 비유는 작은 예제에서는 괜찮았지만 코루틴을 사용한 프로그래밍 스타일의 변화를 설명하는 데 도움이 되지는 않았습니다.
>
> 요약 및 번역: [Structured concurrency - Roman Elizarov](https://medium.com/@elizarov/structured-concurrency-722d765aa952)

## Structured concurrency는 무엇인가요?
Structured concurrency는 동시 프로그래밍에 구조적 접근 방식을 사용하여 컴퓨터 프로그램의 선명도, 품질 및 개발 시간을 향상시키는 것을 목표로 하는 프로그래밍 패러다임입니다. 핵심 개념은 **명확한 진입 및 종료 지점이 있고 종료 전에 생성된 모든 스레드가 완료**되도록 하는 제어 흐름 구조를 통해 동시 실행 쓰레드를 캡슐화하는 것입니다.

Wikipedia의 설명을 요약해봤는데 조금 복잡하지만 중요한 부분은 명확한 진입 및 종료 지점이 있고 종료 전에 생성된 모든 스레드가 완료된다는 점입니다.

## Structured concurrency를 도입하기 전의 코루틴은 무슨 문제가 있었나요?
위 질문에 답하는 코루틴 프로젝트의 [GitHub Issue](https://github.com/Kotlin/kotlinx.coroutines/issues/410#issue-336173724)가 있습니다. 요약하자면 아래와 같습니다.

현재 `launch { ... }` 및 `async { ... }`와 같은 코루틴 빌더는 기본적으로 **글로벌** 코루틴을 시작합니다. 글로벌 코루틴의 수명은 데몬 스레드의 수명과 마찬가지로 완전히 독립형이며 코루틴을 시작한 작업(job)의 수명보다 오래 지속됨을 의미합니다.

이것은 잘못된 기본값인 것 같습니다. 글로벌 코루틴은 에러가 일어나기 쉽습니다. 누출되기 쉽고 병렬 분해 작업이 필요한 일반적인 use-case를 나타내지 않습니다.

두 이미지를 병렬로 불러오고 결합된 결과를 반환하는 코드를 생각해보세요.

```kotlin
suspend fun loadAndCombineImage(name1: String, name2: String): Image {
    val image1 = async { loadImage(name1) }
    val image2 = async { loadImage(name2) }
    return combineImages(image1.await(), image2.await())
}
```

위 코드는 첫번째 이미지 로드에 실패해도 두 번째 이미지 로드가 취소되지 않는 버그가 있습니다. 또한 이 경우 두 번째 이미지를 로드할 때 발생하는 모든 오류가 손실됩니다.

## 참고문서
- [Structured concurrency - Roman Elizarov](https://medium.com/@elizarov/structured-concurrency-722d765aa952)
- [Structured concurrency - Wikipedia](https://en.wikipedia.org/wiki/Structured_concurrency)
- [Change default for global vs child coroutines by scoping coroutine builder (structured concurrency)](https://github.com/Kotlin/kotlinx.coroutines/issues/410#issue-336173724)