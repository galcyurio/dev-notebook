https://www.ibm.com/developerworks/library/l-async/index.html  
위 문서를 이해하기 위해 OS 관련 용어 정리

## Context switch
`하나의 프로세스`가 CPU를 사용중인 상태에서 `다른 프로세스`가 CPU를 사용하도록 하기 위해 `이전의 프로세스`의 상태를 `보관`하고 `새로운 프로세스`의 상태를 `적재`하는 작업이다.  
이 기능이 있음으로써 `여러 프로세스들이 하나의 CPU를 공유`하는 것이 가능해진다.  

## System call
`application`이 파일 시스템을 사용하는 등의 여러 상황에서 `커널`에 의존해야 한다.  
`system call`이란 `운영체제의 커널`이 제공하는 `서비스`에 대해 `application`의 요청에 따라 `커널`에 접근하기 위한 인터페이스이다.  


## Kernel
`커널`은 운영 체제의 핵심이 되는 컴퓨터 프로그램이며 시스템의 모든 것을 완전히 통제한다.


## User space & Kernel space
최신 컴퓨터 운영 체제는 대부분 가상 메모리를 `user space`와 `kernel space`로 분리한다.  
주로, 메모리를 분리함으로써 잘못된 소프트웨어 동작으로부터 메모리 보호와 하드웨어 보호를 제공한다.  
운영체제에서 `user mode`와 `kernel mode`간에 전환할 경우 `context switch`은 필수적이지 않다.  
`mode`를 전환하는 것 자체는 `context switch`이 아니다. 하지만, 운영 체제에 따라서 이 시점에 `context switch`가 발생할 수 있다.


## read system call
POSIX 호환 운영 체제에서 `파일 시스템에 저장된 파일의 데이터에 액세스`해야하는 하는 경우 `read` system call을 사용한다.  
이 system call은 파일에서 호출자가 지정한 `byte만큼 데이터를 읽고` 호출한 프로세스에서 제공한 `buffer에 저장`한다.

## POSIX (portable operating system interface)
운영 체제 간의 호환성을 유지하기 위해 IEEE 컴퓨터 협회가 지정한 표준이다.  
POSIX는 다양한 Unix계열 OS와 다른 OS들의 소프트웨어 호환을 위하여 CLI shell, utility interface 간의 API를 정의한다.


## select system call
POSIX 호환 운영 체제의 system call이며 API이다.  
열린 input/output 채널의 File Descriptor 의 상태를 감시한다.
File Descriptor 중 하나 이상이 일부 class에 의해 I/O 작업에 대해 `ready` 상태가 될 때까지 프로그램이 여러개의 File Descriptor를 감시할 수 있다.


- 참고 문서
  - [Context switch wiki](https://en.wikipedia.org/wiki/Context_switch)
  - [Context switch ko wiki](https://ko.wikipedia.org/wiki/%EB%AC%B8%EB%A7%A5_%EA%B5%90%ED%99%98)
  - [System call ko wiki](https://ko.wikipedia.org/wiki/%EC%8B%9C%EC%8A%A4%ED%85%9C_%ED%98%B8%EC%B6%9C)
  - [Kernel ko wiki](https://ko.wikipedia.org/wiki/%EC%BB%A4%EB%84%90_(%EC%BB%B4%ED%93%A8%ED%8C%85))
  - [User space wiki](https://en.wikipedia.org/wiki/User_space)
  - [POSIX wiki](https://en.wikipedia.org/wiki/POSIX)
  - [read system call wiki](https://en.wikipedia.org/wiki/Read_(system_call))
  - [select system call](http://man7.org/linux/man-pages/man2/select.2.html)