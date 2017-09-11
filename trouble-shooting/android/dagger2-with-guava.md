## Report structure
## Issue summary  
When I migrate pure-dagger2 to android-dagger2, I received following error.
````java
Error:Execution failed for task ':app:compileDebugJavaWithJavac'.
> java.lang.NoSuchMethodError: com.google.common.collect.SetMultimap.forEach(Ljava/util/function/BiConsumer;)V
````

## Environment (integrated library, OS, etc)
````gradle
compileSdkVersion = 25
buildToolsVersion = '25.0.2'
minSdkVersion = 21
targetSdkVersion = 25

daggerVersion = '2.11'
guavaVersion = '23.0-android'
glassfishAnnotationVersion = '10.0-b28'
````

## Expected behavior
Do not throw exception in compile-time.

## Actual behavior
Compiler throws when I compile.

## Issue detail (Reproduction steps, use case)
1. Add dependency either dagger2-android, guava.
2. Follow the [official guide](https://google.github.io/dagger/android.html).
3. Compile.
4. Exception occurred.

## Trouble shooting
I searched and found about related issue in github dagger2 issue page. (link below)  
Details exists in below issues.  

The `SetMultimap.forEach` method exists only non guava lilbrary.  
So I chaged guava version __23-android__ to __android__. And It was worked.  
However It was not really good solution.  
Good solution is already suggested in related issue by [ronshapiro](https://github.com/google/dagger/issues/753#issuecomment-304550945).

My mistake become from my unexperienced knowledge about Gradle.  
Actually, I didn't know __Annotation Processor__ what to do.  

Finally, I applied following good solution.  
````gradle
guavaVersion = '23.0'
````

````gradle
compile "com.google.guava:guava:$rootProject.guavaVersion-android"
annotationProcessor "com.google.guava:guava:$rootProject.guavaVersion"
````


## etc
[Related Issue](https://github.com/google/dagger/issues/753)  