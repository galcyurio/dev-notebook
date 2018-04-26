# I/O models

## Synchronous blocking I/O
`read` system call이 일어나면 application은 `block`되며 user-space에서 kernel-space로 `context switch`가 일어난다.  
그 다음 `read`가 시작되고 응답이 도착하면 데이터가 kernel-space에서 user-space로 이동한다.

![](https://www.ibm.com/developerworks/library/l-async/figure2.gif)  


## Synchronous non-blocking I/O
I/O가 완료될 때까지 대기하지 않고 `read` system call이 일어나면 바로 명령이 완료되지 않았음을 나타내는 `에러코드를 반환`한다.  
그리고 application은 I/O 명령이 완료되는 것을 기다리며 많은 call을 만들게 된다.  
이 모델은 application이 I/O 작업이 끝나고 데이터를 받을 때까지 기다린다거나 또는 커널이 I/O 작업을 하는 사이에 다른 작업을 시도해야 하기 때문에 비효율적일 수 있다.  

![](https://www.ibm.com/developerworks/library/l-async/figure3.gif)


## Asynchronous blocking I/O
non-block I/O 가 구성되고 I/O descriptor에 대한 변화가 있을 때를 확인하기 위해 `blocking select system call` 이 사용된다.  
`select` call은 하나의 descriptor가 아니라 여러개의 descriptor에 대해 알림을 제공할 수 있다.  
각각의 descriptor에 대해서 데이터를 쓸 수 있는지(write), 읽을 수 있는지(read) 그리고 에러가 발생했는지에 대해 알림을 요청할 수 있다.

![](https://www.ibm.com/developerworks/library/l-async/figure4.gif)


## Asynchronous non-blocking I/O (AIO)
`read` 요청은 `read`가 성공적으로 초기화되었음을 알리는 반환값을 즉시 반환한다.  
그리고 application은 `read`가 완료될 때까지 다른 처리를 수행할 수 있다.  
`read`에 대한 응답이 오면 `signal` 또는 `스레드 기반의 callback`을 생성하여 I/O 트랜잭션을 완료시킬 수 있다.

![](https://www.ibm.com/developerworks/library/l-async/figure5.gif)


- 참고 문서
  - https://www.ibm.com/developerworks/library/l-async/index.html
  - https://www.slideshare.net/unitimes/sync-asyncblockingnonblockingio
  - http://ozt88.tistory.com/20
  - https://nesoy.github.io/articles/2017-01/Synchronized
  - https://en.wikipedia.org/wiki/Asynchronous_I/O