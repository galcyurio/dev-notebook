# JPA One-to-Many assocication Best Practice
- referenced posts
  - [vladmihalcea.com](https://vladmihalcea.com/2017/03/29/the-best-way-to-map-a-onetomany-association-with-jpa-and-hibernate/)


## Introduction
@ManyToOne annotation 은 child entity 에서 parent entity 를 매핑하는데 쓰인다. 이 방법은 one-to-many 관계를 매핑하는데 가장 일반적이면서 가장 효율적인 대안이기도 하다.  

하지만 entity state 와 dirty checking 의 장점을 활용하기 위해 @OneToMany annotation 을 사용해서 parent entity 에 collection 형태로 child entity 를 매핑하기도 한다. 
이러한 케이스에서는 collection 을 사용하기 보다는 query 를 사용하는게 fetching performance 측면에서 보면 더 유연하다.  

하지만 collection 을 사용하는 것이 더 나은 경우도 있다. 이 때는 두가지 방법이 있다.
- a unidirectional `@OneToMany` assocication
- a bidirectional `@OneToMany` assocication

bidirectional 의 경우에는 child entity 에서 `@ManyToOne` annotation 을 사용해서 매핑하고 assocication 의 컨트롤 해야 한다.  
반면에 unidirectional 의 경우에는 parent entity 에서 관계를 정의하기만 하면 되니 훨씬 간단하다.  
__다만 `@OneToMany` annotation 의 경우에는 주의할 점이 있다.__


## Unidirectional @OneToMany __(Not recommended)__
id 및 다른 column들은 생략한다.
````groovy
@Entity
class Post {
    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
    List<PostComment> postComments = []
}

@Entity
class PostComment {
}
````

위와 같이 entity 를 작성할 경우 jpa 에서는 마치 Many-to-Many assocication 처럼 `post_post_comment` 라는 테이블을 하나 더 만들어서 관리한다. 따라서 좋지 않은 방법이다.


## Unidirectional @OneToMany with @JoinColumn __(Not Recommended)__
위와 같은 extra join table issue 는 `@JoinColumn` annotation 을 추가하면 된다. `@JoinColumn` annotation 은 name property 를 통해 foreign key column 이 어떤 것인지 알려 줄 수 있다.

````groovy
class Post {
    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "post_id")
    List<PostComment> postComments = []
}
````

위와 같이 entity 를 작성할 경우 extra join table issue 는 해결되지만 다음과 같이 insert 문에 update 문을 같이 실행하는 것을 볼 수 있다.
````sql
Hibernate: insert into post_comment (review, id) values (?, ?)
Hibernate: insert into post_comment (review, id) values (?, ?)
Hibernate: update post_comment set post_comments_id=? where id=?
Hibernate: update post_comment set post_comments_id=? where id=?
````
이유는 바로 Hibernate 의 flush order 때문이다. 
1. inserts
1. updates
1. deletes of collections elements
1. inserts of collections elements
1. deletes

collection 이 처리되기 전에 persist 가 먼저 실행되기 때문에 Hibernate 에서는 child record 들을 foreign key 없이 먼저 insert 한 이후에 collection handling phase 에서 foreign key column 들이 update 된다.  

마찬가지로 collection state 에 대한 수정도 같은 로직이 적용된다.
````java
post.getComments().remove(0);
````
````sql
update post_comment set post_id = null where post_id = 1 and id = 2
delete from post_comment where id=2
````
child entity의 update문까지 같이 실행하는 parent entity state 의 변경이 먼저 실행된다. 그런 다음, collection 이 처리될 때, orphan removal action 이 child row 의 delete 문을 실행한다.


## Bidirectional @OneToMany __(Recommended)__
`@OneToMany` association 을 매핑하는데 가장 좋은 방법은 `@ManyToOne` side 를 통해 모든 entity state 를 관리하는 것이다. 

````groovy
@Entity
class Post {
    @OneToMany(mappedBy = "post", cascade = CascadeType.ALL, orphanRemoval = true)
    List<PostComment> postComments = []

    void addComment(PostComment postComment) {
        postComments.add(postComment)
        postComment.setPost(this)
    }

    void removeComment(PostComment postComment) {
        postComments.remove(postComment)
        postComment.setPost(null)
    }
}

@Entity
class PostComment {
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "post_id")
    Post post
}
````

- `@ManyToOne` association 에서 performance 를 위해서 LAZY fetch
- parent entity 측에서 `addComment` 와 `removeComment` 메서드를 이용해서 양측을 동기화 시킨다.
- child entity 측에서 equals, hashcode 메서드를 구현한다.

위와 같이 entity 를 작성할 경우 persist, remove 할 때 insert문과 delete문이 각각 하나씩 실행이 된다.



## Just @ManyToOne
`@OneToMany` 을 사용해서 collection 을 매핑할 수 있는 경우는 현실적으로는 child entity 의 row가 적을 때이다. `@OneToMany` 로는 collection 의 size 를 제한할 수 없다.   
따라서 대부분의 경우 child side에서 `@ManyToOne` annotation 만 쓰면 된다. 그리고 parent entity 에서 collection 을 가져오는 경우에는 `Query`(HQL, JPQL, native SQL, Criteria) 를 쓰면 된다.

## Conclusion
bidirectional collection 방법이 `@ManyToOne` association 을 통해서 매핑하므로 performance 측면에서 unidirectional 보다 낫다. 하지만 그게 편리하더라도 항상 collection 을 쓸 필요는 없다. 
`@ManyToOne` association 을 활용하여 One-to-Many 관계를 매핑하는게 가장 자연스럽고 효율적이다.
