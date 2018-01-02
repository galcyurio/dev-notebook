# Vaadin ViewCache Exception

## Issue summary
I used the `vaadin4spring` library to create an mvp architecture in vaadin.
However, `ViewCache` instance is not instantiated by spring container. (throws BeanCreationException)

## Environment (integrated library, OS, etc)
- vaadin 8.1.0
- vaadin4spring 2.0.0.RELEASE
- spring boot 1.5.9.RELEASE


## Expected behavior
N/A

## Actual behavior
when instantiating `ViewCache` throws `BeanCreationException`

````error
org.springframework.beans.factory.UnsatisfiedDependencyException: Error creating bean with name 'homeScreen.HomeUI' defined in file 
..............
Caused by: org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'viewCache' defined in class path resource 
..............
````

## Issue detail (Reproduction steps, use case)
The causes are following:  
1. spring try to instantiate `ViewCache`(DefaultViewCache).
1. Constructor of `DefaultViewCache` calls `getCurrentUI().getNavigator()`.
1. But current `UI` is __not exists__.
1. Throws NullPointerException

## Trouble shooting
We have to instantiate `UI` before creating `ViewCache`.
Solution is simple. Just annotate `@UIScope`.  
So Spring will instantiate View or UI before ViewCache.


## Etc...
