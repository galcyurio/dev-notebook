flutter를 설치하면서 에러가 여러 번 일어났는데 구글링을 해도 잘 나오지 않는 버그가 있어서 여기에 공유합니다.
이 버그는 안드로이드 라이센스를 허용해주면서 일어난 버그입니다.

먼저 flutter 공식문서를 잘 따라서 `flutter doctor` 명령어를 날리는 부분까지 왔다고 가정하겠습니다.
아래와 같이 `flutter doctor`를 치고 안드로이드 라이센스를 허용하라는 에러가 발생합니다.

```sh
PS C:\Users\galcy> flutter doctor
Doctor summary (to see all details, run flutter doctor -v):
[√] Flutter (Channel stable, v1.7.8+hotfix.4, on Microsoft Windows [Version 10.0.17134.345], locale ko-KR)

[!] Android toolchain - develop for Android devices (Android SDK version 29.0.2)
    X Android license status unknown.
      Try re-installing or updating your Android SDK Manager.
      See https://developer.android.com/studio/#downloads or visit https://flutter.dev/setup/#android-setup for detailed
      instructions.

.......... 생략 ...........
```

위처럼 에러가 뜨면 `flutter doctor --android-licenses` 명령어를 통해 해결할 수 있습니다.
성공적으로 수행되면 라이센스에 동의할 것인지 묻는 텍스트가 보일것입니다.

다만 여기서 최신의 안드로이드 스튜디오를 설치하고도 sdkmanager를 업데이트하라는 경우가 있었습니다.

```sh
PS C:\Users\galcy> flutter doctor --android-licenses
A newer version of the Android SDK is required. To update, run:
C:\Users\galcy\AppData\Local\Android\sdk\tools\bin\sdkmanager --update
```

위와 같이 안내해주는대로 명령어를 수행하고 마찬가지로 성공한다면 행복한 flutter 코딩을 즐기시면 되고
만약 **java8이 아닌 java9 이상을 쓰고 있다면** 아래와 같이 NoClassDefFoundError를 볼 수 있습니다.


```sh
PS C:\Users\galcy> C:\Users\galcy\AppData\Local\Android\sdk\tools\bin\sdkmanager --update
Exception in thread "main" java.lang.NoClassDefFoundError: javax/xml/bind/annotation/XmlSchema
        at com.android.repository.api.SchemaModule$SchemaModuleVersion.<init>(SchemaModule.java:156)
        at com.android.repository.api.SchemaModule.<init>(SchemaModule.java:75)
        at com.android.sdklib.repository.AndroidSdkHandler.<clinit>(AndroidSdkHandler.java:81)
        at com.android.sdklib.tool.sdkmanager.SdkManagerCli.main(SdkManagerCli.java:73)
        at com.android.sdklib.tool.sdkmanager.SdkManagerCli.main(SdkManagerCli.java:48)
Caused by: java.lang.ClassNotFoundException: javax.xml.bind.annotation.XmlSchema
        at java.base/jdk.internal.loader.BuiltinClassLoader.loadClass(BuiltinClassLoader.java:583)
        at java.base/jdk.internal.loader.ClassLoaders$AppClassLoader.loadClass(ClassLoaders.java:178)
        at java.base/java.lang.ClassLoader.loadClass(ClassLoader.java:521)
        ... 5 more
```


그 이유는 java9 부터는 모듈 개념이 등장했는데 java9 부터는 기본적으로 `java.se` 모듈이 classpath에서 사용가능합니다.
그리고 JAXB API는 java EE API에 속하는데 `java.se`라는 이름으로 알 수 있듯이 java EE API는 `java.se` 모듈에 포함되지 않습니다.
따라서 위와 같은 이유로 우리가 NoClassDefFoundError를 보게 됩니다.

> 참고: https://stackoverflow.com/a/43574427


해결방법은 2가지 정도로 나뉩니다.
첫번째는 환경변수를 통해 모듈을 더해주는 방법이 있고 java8을 설치하는 방법이 있습니다.

문제가 발생한 `sdkmanager` 파일을 뜯어보면 아래와 같은 문구가 있습니다.

```
@rem Add default JVM options here. You can also use JAVA_OPTS and SDKMANAGER_OPTS to pass JVM options to this script.
set DEFAULT_JVM_OPTS="-Dcom.android.sdklib.toolsdir=%~dp0\.."
```

`JAVA_OPTS`와 `SDKMANAGER_OPTS` 변수를 통해서 jvm 옵션을 넘겨줄 수 있다는 내용입니다.
변수에 `--add-modules java.se.ee`를 설정하고 다시 명령어를 날려봅니다.
성공한다면 행복한 flutter 코딩을 즐기시면 되고 **java 11 이상을 쓰신다면** 아래와 같은 에러를 보게될 겁니다.

```sh
PS C:\Users\galcy> C:\Users\galcy\AppData\Local\Android\sdk\tools\bin\sdkmanager --update
Error occurred during initialization of boot layer
java.lang.module.FindException: Module java.se.ee not found
```

이 에러가 일어나는 원인은 JDK11 부터 `Java EE`와 `CORBA` 모듈이 제거되었기 때문입니다.
> [JEP 320: Remove the Java EE and CORBA Modules](http://openjdk.java.net/jeps/320)

java11을 쓰면서 이 에러를 해결해보려고 여러가지 방법을 찾아보았지만 방법을 찾을 수 없었고 java8을 설치하고 sdkmanager를 업데이트했습니다.