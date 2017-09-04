1. 코딩 다음의 모든 과정(빌드) 자동화
	- 빌드 : compile -> package -> deploy

2. jar 파일 관리

3. 다양한 플러그인


## 디렉토리 설명
JavaResouces
1. src/main/java : 소스 폴더
2. src/main/resources : 자원 폴더
3. src/test/java : 테스트 소스 폴더
4. src/test/resuources : 테스트 자원 폴더

5. src : WebContent 와 같은 폴더

6. pom.xml - maven 의 default 설정 파일



## jar 파일 만들기
해당 프로젝트(artifact ID)에 들어가서

1. mvn clean 으로 target 폴더 및 여러가지 청소
2. mvn compile 로 main 의 소스를 컴파일
3. mvn test-compile 로 test 디렉토리의 소스를 컴파일
4. mvn test 로 테스트 해보기
	- 이 명령어를 치면 main 과 test 모두 컴파일 후 test 진행한다.


## Maven Build Lifecycle
이 단계는 7 번 install 을 하게되면 1~6번까지 모두 수행한 후 7번을 수행한다.
마찬가지로 3번 test 를 실행하면 1~2 번을 모두 수행한 후 test 한다.

1. validate
2. compile
3. test
4. package
5. integration-test
6. verify
7. install
8. deploy


## Maven dependency
pom.xml 에서 dependency 는 상위 dependency 를 상속받는다.
따라서 해당 jar 파일이 다른 파일에 대해 dependency 가 있다면
다른 jar 파일도 같이 다운로드 받게 된다.


## 상위 dependency 바꾸기
1. pom.xml에서 바꾸고 싶은 dependency 의 <groupId> 와 <artifactId> 를 복사해온다.

2. 자신의 pom.xml 에서 해당 의존관계에 있는 <dependency> 안에 다음과 같이 작성한다.
````xml
<exclusions>
    <exclusion>
        <groupId>org.jboss.logging</groupId>
        <artifactId>jboss-logging</artifactId>
    </exclusion>
</exclusions>
````
