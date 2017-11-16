## Issue summary
Upgraded firebase-admin library version `5.2.0` to `5.5.0`.
However, It thows NoSuchMethodError.
````
Exception in thread "main" java.lang.NoSuchMethodError: com.google.common.base.Preconditions.checkState(ZLjava/lang/String;Ljava/lang/Object;)V
````

## Environment (integrated library, OS, etc)
- Spring Boot 1.5.8.RELEASE
- Windows 10
- Firebase 5.2.0 -> 5.5.0

## Expected behavior
No Exception.

## Actual behavior
NoSuchMethodError exception occurred.

## Issue detail (Reproduction steps, use case)
1. use multiple version of guava.
2. call method which is in greater version, but not in lower version.

## Trouble shooting
I tried debugging myself, but I failed. So I searched web. 
Fortunately, the solution was waiting for me.  
https://github.com/firebase/firebase-admin-java/issues/50

I excluded lower version of guava, and explicitly included latest version of guava.
And It was solved.

## Etc...