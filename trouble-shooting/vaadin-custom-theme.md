# Vaadin Custom Theme
- referenced posts
  - [official article](https://vaadin.com/docs/v8/framework/themes/themes-compiling.html)
  - [vaadin forum](https://vaadin.com/forum#!/thread/3281129)

## Issue summary
I tried customize theme, but it throws me some exceptions.  


## Environment (integrated library, OS, etc)
- Intellij + Java 8 + Maven
- Created by `Spring initializr`(vaadin checked)
- Spring Boot 1.5.8.RELEASE
- vaadin-spring-boot-starter 8.1.0


## Expected behavior
Introduced [here](https://vaadin.com/docs/v8/framework/themes/themes-compiling.html).
- Compile scss file to css file using maven. (Compiling with Maven) : __best practice__
- Automatically compile scss files when css files not found. (Compiling On the Fly)


## Actual behavior
When I run the server and try to access any page, it throws `java.lang.ClassNotFoundException: com.vaadin.sass.internal.ScssStylesheet`.  
When I used vaadin-maven-plugin, it cannot found `com.vaadin.sass.SassCompiler` class and throws exception also.


## Issue detail (Reproduction steps, use case)
1. Create project using `Spring initializr` and include `vaadin`.
1. Turn theme to `mytheme` using `@Theme` annotation.
1. Run the application and access any page.
1. Exception occurred.


## Trouble shooting
1. First, we have to include `vaadin-sass-compiler` dependency.  
But, `vaadin-server` depends on `vaadin-sass-compiler`.  
Therefore, we can just include `vaadin-server` dependency.  
````xml
<dependency>
    <groupId>com.vaadin</groupId>
    <artifactId>vaadin-server</artifactId>
</dependency>
````

2. Run the application and access some pages.  
Everything is good, however this solution has some drawback.  
Following text taken from the official article.  
> The on-the-fly compilation takes a bit time, so it is only available when the Vaadin servlet is in the development mode, as described in Other Servlet Configuration Parameters. Also, it requires the theme compiler and all its dependencies to be in the class path of the servlet. At least for production, you must compile the theme to CSS, as described next.


## Best practice
Please refer `Compiling with Maven` section in official document. Link is [here](https://vaadin.com/docs/v8/framework/themes/themes-compiling.html).