# docker
- referenced videos
  - [박재성 - docker 1. docker container를 실행하기 위한 환경 설정](https://youtu.be/U_F-eNo3uM0)
  - [박재성 - docker 2. ubuntu 한글 버전 빌드 및 자바 설치](https://youtu.be/2cJnTnBkKac)
  - [박재성 - docker 3. Dockerfile을 활용해 나만의 Docker 이미지 만들기](https://youtu.be/_lM9uotAOmk)
  - [박재성 - docker 4. Docker에 내가 구현한 소스 코드 배포하기](https://youtu.be/E8cdA6ORbSM)
  - [생활코딩 - docker](https://youtu.be/Bhzz9E3xuXY)

- referenced posts
  - [이재홍 - 가장 빨리 만나는 Docker](http://pyrasis.com/docker.html)
  - [Docker Docs](https://docs.docker.com/)

## docker 란?
vmware 또는 virtual box는 가상화 환경으로써 CPU나 다른 자원들을 가상화하여 컴퓨터를 새롭게 만드는 것이지만 
docker 는 linux의 container 기술을 이용해서 가상화를 하지 않고 process만 격리해서 빠르게 실행시키는 기술이다.

- 가상머신과의 차이점
  - 가상머신보다 빠르고 가볍다.
  - process를 격리만 할뿐 OS를 새롭게 만들지 않고 기존 시스템 자원을 공유한다.
- 자동 설치 script 를 지원한다.


## image & container
docker image는 실행파일과 라이브러리가 조합된 것을 image라고 한다.
그리고 container가 image를 실행시킨 상태이다.


## 명령어

### image 찾기
````bash
docker search <image>
````
또는 웹브라우저를 통해 찾을 수 있다.

### pull (image 다운로드)
````bash
docker pull <image>
docker pull <image>:<version>
````

### 현재 다운로드 된 image 보기
````bash
docker images
````

### docker image 실행(container 생성, 실행, 접속)
````bash
# -i 란 interactive 의 약자로서 사용자가 입출력을 할 수 있는 상태로 만들어 준다.
# -t 란 pseudo-TTY 라는 가상 터미널 환경을 할당한다.

# /bin/bash 를 써주는 이유는 docker는 메인으로 실행할 파일을 지정해주어야 하기 때문이다.
# container 에서 메인으로 실행되고 있는 파일이 종료되면 container 도 같이 종료된다.
docker run -i -t <image-name> /bin/bash

# exit 를 할 경우에는 /bin/bash 가 종료되므로 container 도 종료된다.
# --name 옵션을 주면 container 에 name 이 할당되고 주지 않으면 docker 에서 자동적으로 붙여준다.


# 아래 명령어는 docker container 를 만들고 바로 종료한다.
docker run <image_name>
````


### container process 보기
````bash
docker ps

# 종료된 container 까지 보기
docker ps -a
````

### container 시작 및 중지
````bash
docker start <container id 또는 name>
docker stop <container id 또는 name>
````

### container 접속
````bash
docker attach <container id 또는 name>
````
Bash 셸에서 exit 또는 Ctrl+D를 입력하면 컨테이너가 정지됩니다. 
여기서는 Ctrl+P, Ctrl+Q를 차례대로 입력하여 컨테이너를 정지하지 않고, 컨테이너에서 빠져나옵니다.


### 외부에서 container안의 명령 실행하기
````bash
docker exec example_container echo "Hello World"
Hello World
````
docker exec 명령은 이미 실행된 컨테이너에 apt-get, yum 명령으로 패키지를 설치하거나, 각종 데몬을 실행할 때 활용할 수 있습니다.


### container, image 삭제
````bash
# container 삭제
docker rm <container id 또는 name>

# container 모두 삭제
docker rm $(docker ps -a -q)

# image 삭제
docker rmi <image id 또는 name>:<태그>

# image 모두 삭제
docker rmi $(docker images -q)
````