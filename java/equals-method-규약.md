# equals() 메서드 규약

- Reflexive : Object must be equal to itself.
- Symmetric : if a.equals(b) is true then b.equals(a) must be true.
- Transitive : if a.equals(b) is true and b.equals(c) is true then c.equals(a) must be true.
- Consistent : multiple invocation of equals() method must result same value until any of properties are modified. So if two objects are equals in Java they will remain equals until any of there property is modified.
- Null comparison : comparing any object to null must be false and should not result in NullPointerException. For example a.equals(null) must be false, passing unknown object, which could be null, to equals in Java is is actually a Java coding best practice to avoid NullPointerException in Java.