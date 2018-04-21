https://www.ibm.com/developerworks/library/l-async/index.html  
위 문서에 나오는 관련 용어 설명

## Context switch
`하나의 프로세스`가 CPU를 사용중인 상태에서 `다른 프로세스`가 CPU를 사용하도록 하기 위해 `이전의 프로세스`의 상태를 `보관`하고 `새로운 프로세스`의 상태를 `적재`하는 작업이다.  
이 기능이 있음으로써 `여러 프로세스들이 하나의 CPU를 공유`하는 것이 가능해진다.  

## System call
`application`이 파일 시스템을 사용하는 등의 여러 상황에서 `커널`에 의존해야 한다.  
`system call`이란 `운영체제의 커널`이 제공하는 `서비스`에 대해 `application`의 요청에 따라 `커널`에 접근하기 위한 인터페이스이다.  


## Kernel
`커널`은 운영 체제의 핵심이 되는 컴퓨터 프로그램이며 시스템의 모든 것은 완전히 통제한다.


- 참고 문서
  - [Context switch wiki](https://en.wikipedia.org/wiki/Context_switch)
  - [Context switch ko wiki](https://ko.wikipedia.org/wiki/%EB%AC%B8%EB%A7%A5_%EA%B5%90%ED%99%98)
  - [System call ko wiki](https://ko.wikipedia.org/wiki/%EC%8B%9C%EC%8A%A4%ED%85%9C_%ED%98%B8%EC%B6%9C)
  - [Kernel ko wiki](https://ko.wikipedia.org/wiki/%EC%BB%A4%EB%84%90_(%EC%BB%B4%ED%93%A8%ED%8C%85))