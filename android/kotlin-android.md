# 코틀린으로 안드로이드를 시작하면 좋은 점

## Kotlin의 확장 함수
Kotlin을 사용하면 Java를 썼을 때보다 훨씬 좋지만 확장함수 기능을 사용하면 기존의 안드로이드 API를 더욱더 코틀린스럽게 작성할 수 있다. 
또한 이러한 점을 Android팀과 Kotlin팀에서도 인지하고 확장함수를 모아놓은 라이브러리를 제공한다.

### Android팀에서 관리하는 [Android KTX](https://github.com/android/android-ktx)
2018년에 새롭게 소개된 라이브러리다. anko에 비해서 자료는 아직 많지 않지만 확장함수 덩어리일 뿐이라 러닝커브가 거의 없는 편이다.

**Kotlin:**
```kotlin
val uri = Uri.parse(myUriString)
```
**Kotlin with Android KTX:**
```kotlin
val uri = myUriString.toUri()
```

----

**Kotlin:**
```kotlin
sharedPreferences.edit()
    .putBoolean("key", value)
    .apply()
```
**Kotlin with Android KTX:**
```kotlin
sharedPreferences.edit {
    putBoolean("key", value)
}
```

----

**Kotlin:**
```kotlin
val pathDifference = Path(myPath1).apply {
    op(myPath2, Path.Op.DIFFERENCE)
}

canvas.apply {
  val checkpoint = save()
  translate(0F, 100F)
  drawPath(pathDifference, myPaint)
  restoreToCount(checkpoint)
}
```
**Kotlin with Android KTX:**
```kotlin
val pathDifference = myPath1 - myPath2

canvas.withTranslation(y = 100F) {
    drawPath(pathDifference, myPaint)
}
```

----

**Kotlin:**
```kotlin
view.viewTreeObserver.addOnPreDrawListener(
    object : ViewTreeObserver.OnPreDrawListener {
        override fun onPreDraw(): Boolean {
            viewTreeObserver.removeOnPreDrawListener(this)
            actionToBeTriggered()
            return true
        }
    })
```
**Kotlin with Android KTX:**
```kotlin
view.doOnPreDraw {
     actionToBeTriggered()
}
```


### Kotlin팀에서 관리하는 [anko](https://github.com/Kotlin/anko)
anko는 크게 anko-commons, anko-layouts, anko-sqlite, anko-coroutines 로 이루어져 있고 support library를 위한 여러개의 라이브러리들도 있다. 
이 중에 핵심은 `anko-layouts`이지만 `anko-commons`와 `anko-sqlite`는 확장함수를 이용해 안드로이드 API를 코틀린스럽게 쓰게 해준다.

#### anko-commons


**Kotlin:**
````kotlin
Toast.makeText(context, "Hi there!", Toast.LENGTH_SHORT).show()
````
**Kotlin with anko**
````kotlin
toast("Hi there!")
````
-------

**Kotlin**
````kotlin
alert("메세지", "타이틀") {
    positiveButton("삭제한다") { /* 삭제 */ }
    negativeButton("취소") { /* 아무것도 안함 */ }
}.show()
````
**Kotlin with anko**
````kotlin
AlertDialog.Builder(this)
    .setMessage("메세지")
    .setTitle("타이틀")
    .setPositiveButton("삭제한다") { dialog, which -> /* 삭제 */ }
    .setNegativeButton("취소") { dialog, which -> /* 아무것도 안함 */ }
    .create().show()
````

-------

**Kotlin**
````kotlin
val intent = Intent(this, SomeOtherActivity::class.java)
intent.putExtra("id", 5)
intent.setFlag(Intent.FLAG_ACTIVITY_SINGLE_TOP)
startActivity(intent)
````

**Kotlin with anko**
````kotlin
startActivity(intentFor<SomeOtherActivity>("id" to 5).singleTop())
````

### `anko-layouts`를 이용해 XML이 아닌 kotlin으로 레이아웃 생성 가능
- [XML 방식과의 성능비교](https://android.jlelse.eu/400-faster-layouts-with-anko-da17f32c45dd)

xml방식으로 레이아웃을 구성하는 것보다 kotlin으로 구성하게 되면 성능면에서 이득이 있고 기존의 `findViewById`나 `onClick`과 함수들이 레이아웃에 가까워지면서 개발상에도 이득이 있다.

다만 개인적으로 써본 결과 XML에 익숙한 사람이 anko-layouts로 넘어가기에는 anko 플러그인의 preview기능이 부실하고 기존 xml에서 쓰던 속성들을 anko-layouts에서는 어떻게 써야하는지를 개발도중에 IDE상에서 알 수가 없다. 
따라서 구글링을 해가면서 속성 하나하나를 파악해야 하는 단점이 있다. 
또한 플러그인을 통해 xml에서 anko-layouts 로의 자동 변환 기능을 제공하는데 XML에서의 속성들을 제대로 변환하지 못하는 모습을 보여준다.

**XML**
````xml
<LinearLayout
    android:orientation="vertical"
    android:layout_width="match_parent"
    android:layout_height="match_parent">
  
  <TextView
    android:text="TextView"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"/>

</LinearLayout>
````

**anko**
````kotlin
verticalLayout {
  textView("TextView").lparams(matchParent)
}
````

--------
크나큰 단점이자 장점으로 따지자면 ConstraintLayout관련 지원이다.
일단 완성된 코드는 정말 깔끔하지만 그 과정이 조금 고통스럽다.
id를 수동으로 생성해야하고 constraint를 엮는 부분은 XML과 상이하다.
따라서 처음엔 생각보다 러닝커브가 높지만 anko가 조금 더 성숙해지고 개발자도 anko의 방식에 익숙해지면 레이아웃을 만드는데 이보다 나은 툴이 없을 것 같다.


````kotlin
constraintLayout {

    val sessionStart = textView {
        id = R.id.session_start
        textSize = 18f
        textColor = theme.getColor(R.attr.colorAccent)
    }

    val sessionTitle = textView {
        id = R.id.session_title
        textSize = 18f
        textColor = Color.BLACK
    }.lparams(0, wrapContent)

    textView {
        id = R.id.session_details
        textSize = 16f
    }.lparams(0, wrapContent)

    applyConstraintSet {
        // Connect without block
        // You may use view id or view itself to define connections
        connect(
                START of R.id.session_start to START of PARENT_ID margin dip(10),
                TOP of sessionStart to TOP of PARENT_ID margin dip(10)
        )

        // constraint configuration on view
        sessionTitle {
            connect(
                    START to START of PARENT_ID margin dip(SESSION_LIST_HEADER_MARGIN),
                    TOP to TOP of PARENT_ID margin dip(10),
                    END to END of PARENT_ID margin dip(10),
                    BOTTOM to TOP of R.id.session_details
            )

            horizontalBias = 0.0f
            defaultWidth = MATCH_CONSTRAINT_WRAP
        }

        // constraint configuration on view Id
        R.id.session_details {
            connect(
                    START to START of PARENT_ID margin dip(SESSION_LIST_HEADER_MARGIN),
                    TOP to BOTTOM of sessionTitle margin dip(2),
                    END to END of PARENT_ID margin dip(10),
                    BOTTOM to BOTTOM of PARENT_ID margin dip(2)
            )

            horizontalBias = 0.0f
            defaultWidth = MATCH_CONSTRAINT_WRAP
        }
    }
}
````


### 조금 더 쉬운 Dependency Injection
Kotlin을 사용하면 [koin](https://github.com/InsertKoinIO/koin)과 [kodein](https://github.com/Kodein-Framework/Kodein-DI/)이라는 DI 프레임워크를 사용할 수 있다.
기존 안드로이드 플랫폼에서 가장 인기있는 DI 프레임워크는 Dagger2 였고 상당히 급격한 러닝커브를 가지고 있다.
그에 비해 `koin`과 `kodein`은 상대적으로 쉽다.

다만 결정적으로 `Dagger2`에서는 종속성에 문제가 있으면 compile-time에 잡아주고 `koin`과 `kodein`은 runtime에 터진다.


### kotlin-android-extension 플러그인
이 플러그인을 쓰면 이제 `findViewById()`를 전혀 쓰지 않아도 된다.
안드로이드에서 프로젝트를 만들 때 kotlin 지원을 체크하면 기본적으로 포함되는 플러그인이다.



### 이외 자잘한 장점들
  - 자바와의 100% 호환성
  - IDE를 이용해 '자바 -> 코틀린' 자동변환
  - IDE를 이용해 코틀린 코드가 자바로 어떻게 변하는지 확인 가능
  - data class, sealed class
  - nullable type
  - named arguments


### 참고 문서
- https://developer.android.com/kotlin/
- https://gist.github.com/Hazealign/1bbc586ded1649a8f08f
- https://android-developers.googleblog.com/2018/02/introducing-android-ktx-even-sweeter.html
- https://github.com/android/android-ktx
- https://github.com/kotlin/anko
- https://medium.com/@AllanHasegawa/from-dagger2-to-kodein-a-small-experiment-9800f8959eb4