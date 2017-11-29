# Binary Tree
- referenced posts
  - [wikipedia - 이진 트리](https://ko.wikipedia.org/wiki/%EC%9D%B4%EC%A7%84_%ED%8A%B8%EB%A6%AC)

한 node 가 최대 두 개의 child node를 가지는 tree이다. 
하나의 root element 와 두 개의 다른 left, right subtree 로 이루어져 있다. 
binary 인 이유는 하나의 node 가 최대 2개의 child node 를 가질 수 있기 때문이다.

## Glossary
- __parent(부모), children(자식)__ : 한 node의 left, right subtree들은 children 이라 부르고 해당 노드는 subtree들의 parent라고 불린다.
- __root node(루트 노드)__ : 부모가 없는 node 이며 tree는 하나의 root node만을 가진다.
- __directed edge(방향 간선)__ : parent에서 children으로 가는 경로이다.(diagram 의 화살표)
- __leaf node(단말 노드)__ : children node 가 없는 node이다.
- __depth(깊이)__ : root node에서 해당 node까지 가는 path의 길이이다. tree의 특정 depth를 가지는 node의 집합을 level이라 부르기도 한다. root node만 있는 tree의 depth 는 0이다.
- __height(높이)__ : root node에서 가장 깊이 있는 node까지 가는 path의 길이이다. root node만 있는 tree 의 height는 0이다.
- __size(크기)__ : 모든 node 의 개수이다.
- __sibling(형제)__ : 같은 parent 를 가지는 node이다.
- __ancestor(조상), descendant(자손)__ : A node 에서 B node 까지 가는 경로가 존재할 때, root node에 가까운 node 가 ancestor node 이며 다른 한 쪽이 descendant node이다.
