# JPA One-to-One association best way
- [referenced post](https://vladmihalcea.com/2016/07/26/the-best-way-to-map-a-onetoone-relationship-with-jpa-and-hibernate/)

## Domain Model
`Post` and `PostDetails` model
````
*------------------*    *----------------------*
| Post             |    | PostDetails          |
|------------------|    |----------------------|
| id          Long |    | id              Long |
| title     String |    | createdOn       Date |
*------------------*    | createdBy     String |
                        | post            Post |
                        *----------------------*
````
The `Post` entity is the parent, while the `PostDetails` is the child association because the Foreign Key is located in the post_details database table.


## Typical mapping
````java
@Entity
public class PostDetails {
    @Id @GeneratedValue
    private Long id;
    private Date createdOn;
    private String createdBy;
 
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "post_id")
    private Post post;
 
    public PostDetails() {}
    public PostDetails(String createdBy) {
        createdOn = new Date();
        this.createdBy = createdBy;
    }
}

@Entity
public class Post {
    @Id @GeneratedValue
    private Long id;
    private String title;
 
    @OneToOne(mappedBy = "post", cascade = CascadeType.ALL,
     fetch = FetchType.LAZY, optional = false)
    private PostDetails details;
 
    public void setDetails(PostDetails details) {
        this.details = details;
        details.setPost(this);
    }
}
````
이 매핑이 전형적이지만 가장 효율적이지는 않다. 하나의 `Post` 는 하나의 `PostDetails` 만 가지고 `PostDetails` 는 `Post` 없이는 존재할 수 없으므로 `Post` 의 기본키를 자신의 기본키로 쓰는 것이 좋다.

````
*--------------------*         *----------------------*
| Post               |         | PostDetails          |
|--------------------|         |----------------------|
| id          BIGINT |+-------<| post_id       BIGINT |
| title      VARCHAR |         | createdOn   DATETIME |
*--------------------*         | createdBy     BIGINT |
                               *----------------------*
````

PK와 FK는 자주 조회되므로 이 두개를 공유하면 반으로 줄어든다. 이는 인덱스 스캔 속도를 높이기 위해 인덱스를 메모리에 저장할 때 좋다.

unidirectional @OneToOne 관계에서는 lazy fetch 가 되지만, bidirectional @OneToOne 관계의 parent-side 에서는 그렇지 않다. `optional=false` 로 두고 `FetchType.LAZY` 로 설정하면 마치 `FetchType.EAGER` 처럼 작동한다.


## The most efficient mapping
`@OneToOne` 관계 매핑은 `@MapsId` 를 쓰는 것이 가장 좋다. 이렇게하면 `Post` 엔티티 식별자를 사용하여 항상 `PostDetails` 엔티티를 가져올 수 있기 때문에 bidirectional association 조차 필요하지 않다.

````java
@Entity
public class PostDetails {
    @Id
    private Long id;
    private Date createdOn;
    private String createdBy;
 
    @OneToOne(fetch = FetchType.LAZY)
    @MapsId
    private Post post;
 
    public PostDetails() {}
    public PostDetails(String createdBy) {
        createdOn = new Date();
        this.createdBy = createdBy;
    }
}
````

위 방법대로하면 `id` 컬럼은 PK와 FK로 사용된다. `@Id` 열은 더 이상 `@GeneratedValue` 주석을 사용하지 않는데 그 이유는 `id`가 `post` association의 `id`로 채워지기 때문이다.