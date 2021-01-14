# Answer for performance optimization actions

## In question 4.a and 4.b
Using index as b-tree for first_name, last_name, birth_date, and salary will boost up the searching performance. \
b-tree will sort all records in a binary tree in predefined order (ascending or descending). Therefore, all lookup queries can search the right records much faster then if we do not create index for columns.
* Running time before improvement: 101 ms (4.a) and 211 ms (4.a)
* Running time after improvement: 0.04 ms (4.a) and 67.1 ms (4.b)

## In question 4.c
Improve the performance if Group by query by re-odering columns in Group By statement.\
As we can see here, salary has more distinct items than gender (just only 2 replicated values). Therefore, we group by salary first and then gender later which will trigger the hash aggregation to run faster.
* Running time before improvement: 3725 ms
* Running time after improvement: 1388 ms
