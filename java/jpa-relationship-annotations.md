# JPA entity relationship annotations
__original posts__
- [@OneToMany](https://howtoprogramwithjava.com/database-relationships-one-to-many/)
- [@ManyToMany, @OneToOne](https://howtoprogramwithjava.com/database-relationships-many-many-one-one/)
- [@ManyToOne](https://howtoprogramwithjava.com/hibernate-manytoone-unidirectional-tutorial/)


## @OneToMany
- Defines a many-valued association with one-to-many multiplicity.
- If the relationship is bidirectional, the `mappedBy` element must be used to specify the relationship field or property of the entity that is the owner of the relationship.
- 필요 조건
  - many side가 정말로 필요한가?  
  예를 들어 하나의 User가 하나의 Address만을 필요로만 한다면 이 관계는 부적절하다.
  - many side의 entity가 하나의 entity에 매핑되는가?  
  예를 들어 하나의 Address가 여러 개의 User에 매핑된다면 ManyToMany 관계가 적절하다.


## @ManyToMany
- Defines a many-valued association with many-to-many multiplicity.
- If the association is bidirectional, 
  - either side may be designated as the owning side. 
  - the `non-owning side` must use the `mappedBy` element of the ManyToMany annotation to specify the relationship field or property of the owning side.
- 다대다 관계는 보통 RDBMS 상에서 구현이 불가능하니 일대다, 다대일 관계로 해소해야 한다. entity 관계에서도 자주 쓰이진 않는다.


## @OneToOne
- Defines a single-valued association to another entity that has one-to-one multiplicity. 
-  If the relationship is bidirectional, the `non-owning side` must use the `mappedBy` element of the OneToOne annotation to specify the relationship field or property of the owning side.
- 하나의 엔티티는 최대 하나의 엔티티와 매칭된다.
- OneToOne 관계에서는 parent 와 child 의 관계를 정해야 한다. child 는 parent 없이는 존재할 수 없다.
- child 테이블은 parent 테이블의 기본키를 자신의 fk, pk 로 삼아야 한다. child 테이블만의 pk는 존재할 수 없다.


## @ManyToOne
- Defines a single-valued association to another entity class that has many-to-one multiplicity.
- If the relationship is bidirectional, the non-owning `OneToMany` entity side must used the `mappedBy` element to specify the relationship field or property of the entity that is the owner of the relationship.
- unidirectional One-to-Many 관계를 올바르게 매핑하려면 @ManyToOne annotation 만 사용해야 한다. 직관적이지 않을 수 있지만 Hibernate 가 이렇게 작동한다. unidirection 의 경우 child/many side 의 관계만 매핑해야한다.
- 보통 @JoinColumn annotation 과 같이 쓰인다.