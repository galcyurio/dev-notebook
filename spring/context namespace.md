````xml
<!-- 메모리에 올리고 싶은 패키지를 명시할 수 있다. -->
<context:component-scan base-package="com.sds.board.controller" />
````

````java
@Autowired
@Qualifier("boardDAOmybatis")
private BoardDAO boardDAO;

@autowired
// 를 통해 위빙가능

@Qulifier 
// 를 통해 여러가지 중 한 가지 선택 가능
````