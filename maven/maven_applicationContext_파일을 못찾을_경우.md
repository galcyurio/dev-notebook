스프링 컨텍스트 설정파일과 URI 경로를 제대로 못찾는 삽질


실행 환경

1) IntelliJ 11 에서 프로젝트 생성 : Maven Plugin
2) pom.xml에 maven war plugin 추가

````xml
<plugins>
    <!-- ... -->
    <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-war-plugin</artifactId>
        <version>2.3</version>
        <configuration>
            <webXml>web\WEB-INF\web.xml</webXml>
        </configuration>
    </plugin>
</plugins>
````

3) Add Framework Support 에서 Tomcat 추가.



## Issue

1) spring의 servlet 설정파일을 못찾음

Caused by: java.io.FileNotFoundException: Could not open ServletContext resource [/WEB-INF/dispatcher-servlet.xml]

원인 : Tomcat 이 자동생성해주는 web.xml 경로는 web/WEB-INF/web.xml 임.
그런데 maven-war-plugin 이 인식하는 디폴트 경로는 src/main/web/WEB-INF/web.xml 임
(http://maven.apache.org/plugins/maven-war-plugin/examples/adding-filtering-webresources.html)

고로 다음과 같이 변경해 줘야 함.

````xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-war-plugin</artifactId>
    <version>2.3</version>
    <configuration>
        <webResources>
            <resource>
                <directory>web</directory>
            </resource>
        </webResources>
    </configuration>
</plugin>
````


2) 실행하면 루트(/) 가 매핑되지 않음


WARNING: No mapping found for HTTP request with URI [/WEB-INF/views/index.jsp] in DispatcherServlet with name 'dispatcher'

원인 : web.xml 에서 다음과 같이 서블릿을 매핑했었음.
url-pattern 을 /* 가 아닌 / 으로 수정해야 정상 동작함

````xml
<servlet-mapping>
    <servlet-name>dispatcher</servlet-name>
    <url-pattern>/*</url-pattern>
</servlet-mapping>
````