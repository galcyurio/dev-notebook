# Binary Search Tree(BST : 이진 탐색 트리)
- referenced posts
  - [wikipedia - 이진 탐색 트리](https://ko.wikipedia.org/wiki/%EC%9D%B4%EC%A7%84_%ED%83%90%EC%83%89_%ED%8A%B8%EB%A6%AC)

## Basic
- 각 node에 값이 있다.
- 각 node의 key값은 모두 달라야 한다.
- 값들은 전순서(totally ordered set)가 있다.
- node의 left subtree에는 그 node의 값보다 작은 값들을 지닌 node들로 이루어져 있다.
- node의 right subtree에는 그 node의 값보다 큰 값들을 지닌 노드들로 이루어져 있다.
- left right subtree는 각각이 다시 binary search tree여야 한다.
- 중복된 node가 없어야 한다.

## 검색
- BST에서 key `x`를 가진 node를 검색하고자 할 때, tree의 해당 node가 존재하면 해당 node를 반환하고, 존재하지 않으면 `NULL`을 반환한다.
- 검색하고자 하는 값을 root node와 검저 비교하고, 일치할 경우 root node를 반환한다.
  - 불일치하고 검색하고자 하는 값이 root node보다 작을 경우 left subtree에서 재귀적으로 검색한다.
  - 불일치하고 검색하고자 하는 값이 root node보다 클 경우 right subtree에서 재귀적으로 검색한다.

## 삽입
- 삽입을 하기 전, 검색을 수행한다.
- tree를 검색한 후 key와 일치하는 node가 없으면 마지막 node에서 key와 node의 크기를 비교해서 left 또는 right 쪽에 새로운 subtree node를 삽입한다.

## 삭제
삭제하려는 node의 children 수에 따라 다르다.
- 0 children (leaf node) : 해당 node를 삭제한다.
- 1 children : 해당 node를 삭제하고 그 위치에 해당 node의 child node를 대입한다.
- 2 children
  - 삭제하고자 하는 node의 값을 해당 node의 left subtree에서 가장 큰 값으로 대체하고 가장 큰 값을 가지는 node는 삭제한다.
  - 삭제하고자 하는 node의 값을 해당 node의 right subtree에서 가장 작은 값으로 대체하고 가장 작은 값을 가지는 node는 삭제한다.