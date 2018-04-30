# Block, Non-Block 개념
### Block
호출 이후 응답할 때까지 다른 작업을 진행할 수 없다.

### Non block
호출 이후 즉시 응답을 받으며 그 뒤에 다른 작업을 진행할 수 있다.

# 동기(Synchronous), 비동기(Asynchronous) 개념

`동기`적으로 작업을 수행하면 해당 작업을 끝마치기 전까지 다른 작업을 수행할 수 없다.  
`비동기`적으로 작업을 수행하면 해당 작업이 끝나기 전에 다른 작업을 수행할 수 있다.

컴퓨터의 맥락으로 보았을 때 이 말은 다른 `thread`에서 프로세스나 작업을 실행하는 것으로 해석된다.  
`thread`는 작업 단위로 존재하는 일련의 명령들(코드 블럭)이다.  
`운영체제`는 여러개의 `thread`를 관리할 수 있으며 다른 `thread`로 전환하고 그 `thread`에 작업을 할당하기 전에 `processor의 시간(piece of proccessor time)`을 할당한다.  
`processor`에서는 단순히 명령들을 수행하며 두 개를 동시에 처리하는 개념은 존재하지 않는다.  
`운영체제`는 이 것을 여러 `thread`에 시간을 할당하고 이를 시뮬레이션한다.

이제 여러개의 `core`/`processor`를 혼합하여 도입하면 실제로 동시에 상황이 발생할 수 있다.  
`운영체제`는 첫 번째 `processor`의 한 `thread`에 시간을 할당하고 다른 `processor`의 다른 `thread`에 `같은 시간 블록(same block of time)`을 할당할 수 있다.  
이 모든 작업은 `운영체제`가 작업의 완료를 관리할 수 있도록 하며 코드를 계속 진행하고 다른 작업을 수행할 수 있게 한다.

<hr>

# 동기, 비동기의 의미

### 일반적인 사전적 의미
  - sync : occurring at the same time (동시에 발생한다)
  - async : not occurring at the same time (동시에 발생하지 않는다)

많은 사람들이 위의 일반적인 사전적인 의미 때문에 혼란을 겪는다. 잘못 이해하면 오해를 불러일으킬 수 있다. 


### 관계 또는 의존성의 관점에서의 의미
  - sync : dependent(의존)
  - async : independent(독립)

synchronous 또는 synchronized는 어떤 식 으로든 `연결(connected)`또는 `의존(dependent)`을 의미한다.  
즉, 두 개의 `동기 작업`이 서로 인식되어야하며, 한 작업은 다른 작업이 끝날 때까지 대기하는 것처럼 다른 작업에 대해 종속적이어야 한다.
`비동기`는 모든 것이 독립적이고 초기화나 실행과 같은 어떤 방식으로든 다른 작업에 대해 관계가 없는 것을 의미한다.



- 참고 문서
  - https://stackoverflow.com/a/748189/6686126
  - https://stackoverflow.com/a/748235/6686126