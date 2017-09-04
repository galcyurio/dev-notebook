# Jackson

## jackson Collection with JsonType lost issue

[GitHub/Issue with JsonTypeInfo and Lists](https://github.com/FasterXML/jackson-databind/issues/23)
````java
mObjectWriter = mObjectMapper.writerFor(mObjectMapper.getTypeFactory().constructCollectionType(List.class, MyClass.class));
````