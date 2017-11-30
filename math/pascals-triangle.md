# Pascal's Triangle (파스칼의 삼각형)
- referenced posts
  - [mathsisfun](http://www.mathsisfun.com/pascals-triangle.html)
To build the triangle, start with "1" at the top, then continue placing numbers below it in a triangular pattern.  
Each number is the numbers directly above it added together.

## 삼각형의 패턴

### Symmetrical (대칭)
좌측과 우측의 숫자가 대칭을 이룬다.

### Horizontal Sums
horizontal sum 은 __2의 제곱__이다.

### Exponents of 11 (11의 지수)
각 라인은 11의 지수이다.
````
11^0 =      1
11^1 =     1 1
11^2 =    1 2 1
11^3 =   1 3 3 1
11^4 =  1 4 6 4 1
11^5 = 1 5 10 10 5 1
````


### Squares
두 번째 대각선의 경우 숫자의 제곱은 그 옆에있는 숫자와 아래에있는 숫자의 합과 같다.
````
 1 4  6  4 1
1 5 10 10 5 1
````
4^2 = 6+10

### Fibonacci Sequence (피보나치 수열)
### (Odds and Evens) 홀수와 짝수


## Formula (공식)
Combinations without Repetition 의 공식과 같다.  
__n! / r!(n-r)!__