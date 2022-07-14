## Quicksort implementation in C++
This implementation is for illustrating how Quicksort algorithm works for computer architecture students at Shahid
Beheshti University, so that maybe they can implement it in MIPS assembly easier and with more sense of what they are
doing.   
This implementation selects a random element as the pivot and all the students' implementation should use this 
methodology as well.

## Function
It simply sorts an array.

### Input
In the first line, the count of the numbers to sort, n, is given.   
In the next n lines the elements of the array are given.

### Output
In each line of the output place each element of the ascending sorted array.

### Input Example 1
```
5
1
5
3
4
2
```

### Output Example 2
```
1
2
3
4
5
```


## Build
To build this implementation, first compiler tha `quicksort.cpp` file using any C++ compiler you have e.g., GNU's `g++`.
```shell
g++ quicsort.cpp -o quicksort
```
Then run the output binary:
```shell
./quicksort
```