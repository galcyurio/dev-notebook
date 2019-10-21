## Issue summary
윈도우의 window subsystems linux (이하 wsl)에서 gitlab community edition을 설치하다가 redis service 실행에서 멈춰있는 오류에 대한 해결방법입니다.

## Environment (integrated library, OS, etc)
- window subsystems linux (Ubuntu 18.04.3 LTS) 
- windows 10 Pro 1903 (OS build: 18362.418)

## Expected behavior
`sudo gitlab-ctl reconfigure` 입력 후 정상적으로 gitlab이 재설정되어야 합니다.

## Actual behavior
`sudo gitlab-ctl reconfigure` 입력 후 `ruby_block[wait for redis service socket] action run` 메세지가 보인 뒤 계속해서 실행되기를 기다립니다.

## Issue detail (Reproduction steps, use case)
https://gitlab.com/gitlab-org/omnibus-gitlab/issues/4257#note_171862038

위 글에서 볼 수 있듯이 자체 도커 이미지를 사용하지 않고 컨테이너에서 실행중인 사용자 패키지는 init 시스템이 runit 서비스를 시작할 것으로 예상하고 있습니다.

## Trouble shooting
initsystem 없이 직접 시작해야합니다. 설치 후 reconfigure 명령을 실행하기 전에 `/opt/gitlab/embedded/bin/runsvdir-start &` 를 실행하여 백그라운드에서 runit 서비스를 시작해야 합니다.
그 후에 `sudo gitlab-ctl reconfigure`를 실행하면 됩니다.
