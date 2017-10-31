# StackOverflow error when uses __lombok__ and __JPA bi directional one to many relationship__

## Issue summary
StackOverflow error occurred when I used __Lombok @Data__ annotation and also uses __JPA @OneToMany__ annotation in inverse end side.

## Environment (integrated library, OS, etc)
- Lombok 1.16.18
- Hibernate 5.2.11.Final

## Expected behavior
No error when execute __toString()__ method.

## Actual behavior
StackOverflow error occrred when execute __toString()__ method.

## Issue detail (Reproduction steps, use case)
````java
@Entity
@Data
@NoArgsConstructor
@RequiredArgsConstructor
public class Guide {
    @Id 
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "staff_id", nullable = false) 
    @NonNull 
    private String staffId;
    
    @NonNull 
    private String name;
    
    @NonNull 
    private Integer salary;

    @OneToMany(mappedBy = "guide", cascade = CascadeType.PERSIST)
    private Set<Student> students = new HashSet<>();
}
````

````java
@Entity
@Data
@NoArgsConstructor
@RequiredArgsConstructor
public class Student {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "enrollment_id", nullable = false)
    @NonNull
    private String enrollmentId;

    @NonNull
    private String name;

    @ManyToOne(cascade = {CascadeType.PERSIST, CascadeType.REMOVE})
    @JoinColumn(name = "guide_id")
    @NonNull
    private Guide guide;
}
````

````java
public static void main(String[] args) {
    Session session = HibernateUtil.getSessionFactory().openSession();
    Transaction transaction = session.beginTransaction();

    Guide guide = session.load(Guide.class, 1L);
    System.out.println(guide.getStudents());  // StackOverflow error

    transaction.commit();
    session.close();
}
````


## Trouble shooting
Exclude __@OneToMany__ field which in inverse end side like following code.
````java
@Entity
@Data
@ToString(exclude = "students") // add this
@EqualsAndHashCode(exclude = "students")  // add also
@NoArgsConstructor
@RequiredArgsConstructor
public class Guide {
}
````
