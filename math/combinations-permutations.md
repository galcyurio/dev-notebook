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

### `Permutations with Repetition`
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


### `Permutations without Repetition`
In this case, we have to reduce the number of available choices each time.  
The formula is:  
__n! / (n-r)!__  
where __n__ is the number of things to choose from, and we choose __r__ of them,
no repetitions, order matters.


## Combinations
- __Repetition is Allowed__: such as coins in your pocket (5,5,5,10,10)
- __No Repetition__: such as lottery numbers (2,14,15,27,30,33)


### `Combinations with Repetition`
순서와 상관없으며 반복하여 선택할 수 있는 경우이다.

1. 고르는 경우와 고르지 않고 넘어간 경우를 그림으로 나타내 본다.(5가지 중 3번 고르는 경우)  
````
XOOOXXX
````

2. 그린 그림을 바탕으로 __O__와 __X__를 다르게 놓을 수 있는 경우의 수를 구한다.
````
OXXOOXX
XXXXOOO
OXOOXXX
..
````

3. 이렇게 되면 7개 중 3개를 반복없이 고르는 경우가 되므로 Combinations without Repetition 공식에서 __n__이 __r+n-1__ 이 된다.  

__formula = (r+n-1)! / r!(n-1)!__


### `Combinations without Repetition`
This is how lotteries work. The numbers are drawn one at a time, and if we have the lucky numbers (no matter what order) we win!
- assume that the order does matter (ie permutations),
- then alter it so the order does not matter.

__formula = n! / r! (n-r)!__  
where __n__ is the number of things to choose from,
and we choose __r__ of them, no repetition, order doesn't matter.  

반복을 제외한 순열(Permutations without Repetition) 을 구한다음 __r!__ 으로 나눈다.




## 간단한 예제
1, 2 에서 2가지를 고르는 경우

1. Permutations with Repetition  
11 22 12 21

1. Permutations without Repetition  
12 21

1. Combinations without Repetition  
12

1. Combinations with Repetition  
12 22 11