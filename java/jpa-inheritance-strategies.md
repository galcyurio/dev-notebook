# JPA Interitance Strategies

[original post](https://www.thoughts-on-java.org/complete-guide-inheritance-strategies-jpa-hibernate/)


## Mapped Superclass
super class 는 entity 가 아니게 되며 각각의 sub class들은 각각의 table에 매핑된다.

````java
@MappedSuperClass
public abstract class SuperClass {}
````

### 장점
- 가장 간단하다.
### 단점
- polymorphic query 사용 불가
- 다른 entity 와의 관계 선언 불가


--------------------------------------------------------------------------
## Table per Class
Mapped Superclass 와 유사하며 가장 큰 차이점은 super class 가 entity 라는 것이다. 또한 각각의 sub class 들은 여전히 각각의 table 에 매핑된다.

````java
@Entity
@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
public abstract class SuperClass {}
````

### 장점
- polymorphic query 사용 가능
- 다른 entity 와의 관계 선언 가능
### 단점
- polymorphic query 복잡성 증가(join 문, union 문 -> performance 저하)
- subclass 가 늘어날수록 나빠짐

--------------------------------------------------------------------------
## Single Table
모든 entity들의 상속 구조를 같은 table 에 매핑한다.

````java
@Entity
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name = “SUB_CLASS_TYPE”)
public abstract class SuperClass {}

@Entity
@DiscriminatorValue("Sub")
public class SubClass extends SuperClass {}

@Entity
@DiscriminatorValue("Sub2")
public class Sub2Class extends SuperClass {}
````

### 장점
- polymorphic query 효율성 증가(best performance!)
### 단점
- 필수적으로 table 에 null 을 사용하게 됨(NOT NULL 제약조건 사용 불가)
- 데이터의 무결성 이슈가 발생


--------------------------------------------------------------------------
## Joined
각각의 class 들이 각각의 table 에 매핑된다. 여기까지는 table per class 와 비슷하지만 super class 또한 데이터베이스 table 에 매핑된다. 그리고 이 table 에는 각각의 sub class 들이 공유하는 속성들이 매핑된다.

````java
@Entity
@Inheritance(strategy = InheritanceType.JOINED)
public abstract class SuperClass {}
````

### 장점
- NOT NULL 제약조건 사용 가능
- 데이터 무결성 이슈에 안전해짐
### 단점
- sub class entity의 모든 값을 불러오려면 2개의 table을 join해야 한다.


--------------------------------------------------------------------------
## Choosing a Strategy
- best performance && polymorphic query && entity relationship 
  - -> __single table strategy__ && __data integrity issue__

- (data consistency > performance) && polymorphic query && entity relationship 
  - -> __joined strategy__

- `!`polymorphic query && `!`entity relationship 
  - -> __table per class__ && __data consistency__ && __expensive polymorphic query__
