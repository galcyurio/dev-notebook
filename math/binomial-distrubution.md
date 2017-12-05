# Binomial Distrubution (이항 분포)
- referenced posts
  - [mathsisfun - binomial-distribution](http://www.mathsisfun.com/data/binomial-distribution.html)

__"Bi" 는 "2개" 를 뜻한다.__ 따라서 이 것은 __2개의 결과__에 관한 것이다.

## 용어
- Random Variables(확률 변수) : random experiment(trial)에서 가능한 값의 집합이다.


## 공식 만들기
````
Example: You sell sandwiches. 70% of people choose chicken, the rest choose something else.
What is the probability of selling 2 chicken sandwiches to the next 3 customers?
````
tree diagram 을 그려보면 probability 는 다음과 같다.  
0.147  
= 0.7 * 0.7 * 0.3  
= 0.7^2 * 0.3  
= p^k * 0.3^1  
= __p^k * (1-p)^(n-k)__

- __p__ is the probability of each choice we want
- __k__ is the the number of choices we want
- __n__ is the total number of choices

이제 여기에 해당 probability 가 나올 경우의 수를 곱하면 위 문제의 답이 나온다.
3가지를 이미 골랐다고 가정하고 이 중에서 2가지가 `치킨`일 경우의 수를 찾아본다.
이 경우는 순서가 상관이 없고 반복이 불가능하므로 __Combinations without Repetition__ 이다.
````
n=3, r=2
n! / r!(n-r)!
= 3! / 2! 1!
= 3
````
이제 여기에 아까 도출된 답을 곱하면 위 문제에서 요구하는 probability 가 도출된다.  
0.147 * 3 = 0.441

여기까지 사용했던 식들을 공식으로 만들어본다.  
__`P(k out of n) = p^k * (1-p)^(n-k)  *  n! / k!(n-k)!`__  
__`Number of outcomes we want` * `Probability of each outcome`__
이것이 바로 기본적인 Binomial Probability 공식이다.

### Important Summary
- The trials are independent.
- There are only two possible outcomes at each trial,
- The probability of "success" at each trial is constant.

## Mean, Variance and Standard Deviation
<!-- TODO:  -->