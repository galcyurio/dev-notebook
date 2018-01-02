# JPA entity relationship annotations
__original posts__
- howtoprogramwithjava.com
  - [@OneToMany](https://howtoprogramwithjava.com/database-relationships-one-to-many/)
  - [@ManyToMany, @OneToOne](https://howtoprogramwithjava.com/database-relationships-many-many-one-one/)
  - [@ManyToOne](https://howtoprogramwithjava.com/hibernate-manytoone-unidirectional-tutorial/)
- hibernate javadoc
  - [@OneToMany](https://docs.jboss.org/hibernate/jpa/2.1/api/javax/persistence/OneToMany.html)
  - [@ManyToMany](https://docs.jboss.org/hibernate/jpa/2.1/api/javax/persistence/ManyToMany.html)
  - [@OneToOne](https://docs.jboss.org/hibernate/jpa/2.1/api/javax/persistence/OneToOne.html)
  - [@ManyToOne](https://docs.jboss.org/hibernate/jpa/2.1/api/index.html?javax/persistence/OneToMany.html)
- 자바 ORM 표준 JPA 프로그래밍 - 김영한

## Glossary
- uni-directional (단방향) 
- bi-directional (양방향) 
- multiplicity (다중성) : OneToMany, ManyToMany, OneToOne, ManyToOne
- owner (of relationship) : bi-directional 관계과 되면 owner 를 정해야 한다.

## @OneToMany
- OnetoMany `multiplicity` 와 many-valued `association` 을 정의한다.
- bidirectional 관계일 경우 `mappedBy`속성에 관계의 owner인 entity의 field 또는 property를 지정해야 한다.
- 필요 조건
  - many side가 정말로 필요한가?  
  예를 들어 하나의 User가 하나의 Address만을 필요로만 한다면 이 관계는 부적절하다.
  - many side의 entity가 하나의 entity에 매핑되는가?  
  예를 들어 하나의 Address가 여러 개의 User에 매핑된다면 ManyToMany 관계가 적절하다.
