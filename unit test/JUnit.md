# jUnit
 From, http://www.nextree.co.kr/p11104/


## 대표적인 단정문
    assertArrayEquals(a,b) : 배열 a와b가 일치함을 확인
    assertEquals(a,b) : 객체 a와b의 값이 같은지 확인
    assertSame(a,b) : 객체 a와b가 같은 객체임을 확인
    assertTrue(a) : a가 참인지 확인
    assertNotNull(a) : a객체가 null이 아님을 확인
    이외에도 다양한 단정문이 존재합니다. 자세한 내용은 아래 링크를 가시면 확인하실 수 있습니다.
    http://junit.org/junit4/javadoc/latest/org/junit/Assert.html

## 어노테이션 활용하기

Java 언어 자체가 좀 더 넓게 확장하고 다양하게 발전할 수 있도록 도와준 어노테이션을 JUnit에서 활용할 수 있습니다.

### (1) 테스트 메소드 지정하기

@Test가 메소드 위에 선언되면 이 메소드는 테스트 대상 메소드임을 의미합니다.
````java
@Test
public void testSum() {}
````
### (2) 테스트 메소드 수행시간 제한하기

`@Test(timeout=5000)`를 메소드 위에 선언합니다. 시간단위는 밀리 초 입니다. 이 테스트 메소드가 결과를 반환하는데 5,000밀리 초를 넘긴다면 이 테스트는 실패입니다.
````java
@Test(timeout=5000)
public void testSum() {}
````

### (3) 테스트 메소드 Exception 지정하기

`@Test(expected=RuntimeException.class)`가 메소드 위에 선언되면 이 테스트 메소드는 `RuntimeException`이 발생해야 테스트가 성공, 그렇지 않으면 실패입니다.
````java
@Test(expected=RuntimeException.class)
public void testSum() {}
````

### (4) 초기화 및 해제

`@BeforeClass`, `@AfterClass`가 메소드 위에 선언되면 해당 테스트 클래스에서 딱 한 번씩만 수행되도록 지정하는 어노테이션 입니다.
````java
@BeforeClass
public static void setUpBeforeClass() throws Exception {}

@AfterClass
public static void tearDownAfterClass() throws Exception {}
````

`@Before`, `@After`가 메소드 위에 선언되면 해당 테스트 클래스 안에 메소드들이 테스트 되기 전과 후에 각각 실행되게 지정하는 어노테이션 입니다.

````java
@Before
public void setUp() throws Exception {}

@After
public void tearDown() throws Exception {}
````

## Test 메서드
`@Test` 메서드는 다른곳에서 호출하는 메서드가 아니므로 항상 직관적인 메서드명을 지니게 한다.
````java
// ex
@Test
public void saveTask__mustReturnPositiveInteger(){}

@Test
public void WHEN__save_task__THEN__must_return_positive_integer(){}

@Test
public void placeOrder_Must_Return_An_Order(){}
````
