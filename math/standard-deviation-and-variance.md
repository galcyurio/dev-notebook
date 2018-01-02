# `Standard deviation` and `Variance`
- [referenced post](http://www.mathsisfun.com/data/standard-deviation.html)


## Standard deviation
- standard deviation is a measure of how spread out numbers are.
- fomula is __Square root__ of the __Variance__

## Variance
- The average of the `squared` differences from the `Mean`
- To calculate the Variance
  1. take each difference. 
  2. square it
  3. take mean

````java
private static double mean(int... arr) {
    return IntStream.of(arr)
            .average()
            .getAsDouble();
}

private static double variance(int... arr) {
    double mean = mean(arr);
    return IntStream.of(arr)
            .mapToDouble(it -> mean - it)
            .map(it -> Math.pow(it, 2))
            .map(it -> it / arr.length)
            .sum();
}

private static double standardDeviation(int... arr) {
    double variance = variance(arr);
    return Math.sqrt(variance);
}
````