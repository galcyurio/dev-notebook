# Report structure

## Issue summary
When I used custom TextAppearance, it causes strange behavior.  

## Environment (integrated library, OS, etc)
Android, Calligraphy, ...

## Expected behavior
__Warning: Android preview show me like following image, It is not reflected calligraphy bold textAppearance.__  
![Expected](images/cut-expected.png)

## Actual behavior
![Actual](images/cut-actual.png)

## Issue detail (Reproduction steps, use case)
I used calligraphy for custom font.  
And I used this library with __styles.xml__.  This method so flexible and can set __style__ attribute and also __android:textAppearance__ attribute.  
That's why I used this with custom style.


Anyway, let me show you some codes and xml files.  


## 0. Initial
__styels.xml__
````xml
<style name="TextAppearance.Bold" parent="android:TextAppearance">
    <item name="fontPath">fonts/NotoSansKR-Bold.otf</item>
</style>

<style name="ToolbarTitle">
    <item name="android:textAppearance">@style/TextAppearance.Bold</item>
    <item name="android:textColor">@color/colorPerviComple</item>
    <item name="android:textSize">18sp</item>
</style>
````

__custom_view.xml__
````xml
<TextView
    android:layout_width="wrap_content"
    android:layout_height="wrap_content"
    android:textStyle="bold"
    android:textAppearance="@style/TextAppearance.Bold"/>
````

__CustomView.java__
````java
// ...
case R.styleable.CustomView_cv_title_textAppearance:
  //noinspection deprecation
  mTxtTitle.setTextAppearance(getContext(), typedArray.getResourceId(index, -1));
  break;
// ...
````

__activity_main.java__
````xml
<com.github.galcyurio.CustomView
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    app:cv_title="ASDF1234ASDF"
    app:cv_title_textAppearance="@style/TextAppearance.Regular"/>
````

### __Result__
![Actual](images/cut-actual.png)

## Trouble shooting
I wonder about this issue so I tried many of solution.  
However, I don't know what is best practice.  
I'll just show you some success and failed solutions.

## 1. [Success] Initial -> Remove __android:textStyle="bold"__ from __custom_view.xml__
__custom_view.xml__
````xml
<TextView
    android:layout_width="wrap_content"
    android:layout_height="wrap_content"
    android:textAppearance="@style/TextAppearance.Bold"/>
````

### __Result__
![Expected](images/cut-expected.png)

## 2. [Failed] Initial -> Remove __android:textStyle="bold"__ and __android:textAppearance="@style/TextAppearance.Bold"__ from __custom_view.xml__
__custom_view.xml__
````xml
<TextView
  android:layout_width="wrap_content"
  android:layout_height="wrap_content"/>
````

### __Result__
![Actual-2](images/cut-actual-2.png)

## 3. [Success] Initial -> Set parent __Theme.AppCompat.Light.NoActionBar__
__styles.xml__
````xml
<style name="ToolbarTitle" parent="Theme.AppCompat.Light.NoActionBar">
  <item name="android:textAppearance">@style/TextAppearance.Bold</item>
  <item name="android:textColor">@color/colorPerviComple</item>
  <item name="android:textSize">18sp</item>
</style>
````

### __Result__
![Expected](images/cut-expected.png)

## Finally
I realized should not uses multiple TextAppearance even though set the textAppearance programatically like __CustomView.java__.  
Sadly, my silly brain do not know why this wrong behavior occurred.  
I wish this post helps you.  
And if you know why this behavior, please tell us.