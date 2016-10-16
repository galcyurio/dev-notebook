Mockito.mock();
	Mock 객체를 만들어 낸다.

````
@Mock
	Mock 객체임을 애노테이션 으로 명시한다.

MockitoAnnotations.initMocks(this);
	Mockito 어노테이션이 선언된 변수들은 객체를 만들어냅니다.
````

Mockito.when();
	메서드를 뽑아낸다.
	당신이 Mock객체의 특정 메서드를 호출했을 때 특정한 값을 return 받길 원하는 경우 사용한다.
