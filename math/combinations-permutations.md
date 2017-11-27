# Combinations and Permutations
- referenced posts
  - [mathsisfun](http://www.mathsisfun.com/combinatorics/combinations-permutations.html)

## Difference
- When the order doesn't matter, it is a __Combination__.
- When the order does matter it is a __Permutation__.
- A Permutation is an __ordered__ Combination.


## Permutations
- __Repetition is Allowed__: such as the lock above. It could be "333".
- __No Repetition__: for example the first three people in a running race. You can't be first and second.

### Permutations with Repetition
choosing __R__ of something that has __N__ different types, the permutations are:
````
N × N × ... (R times)
````
(In other words, there are __N__ possibilities for the first choice, THEN there are __N__ possibilites for the second choice, and so on, multplying each time.)  
Which is easier to write down using an exponent of r:
````
N × N × ... (R times) = NR
````

formula is simply:   
__n^r__  
where __n__ is the number of things to choose from, and we choose __r__ of them,
repetition is allowed, and order matters.


### Permutations without Repetition
In this case, we have to reduce the number of available choices each time.  
The formula is:  
__n! / (n-r)!__  
where __n__ is the number of things to choose from, and we choose __r__ of them,
no repetitions, order matters.


## Combinations
- __Repetition is Allowed__: such as coins in your pocket (5,5,5,10,10)
- __No Repetition__: such as lottery numbers (2,14,15,27,30,33)

### Combinations with Repetition
Hard to explain.

### Combinations without Repetition
This is how lotteries work. The numbers are drawn one at a time, and if we have the lucky numbers (no matter what order) we win!
- assume that the order does matter (ie permutations),
- then alter it so the order does not matter.
