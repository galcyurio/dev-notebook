# Git CLI (Command Line Interface)
	
	git [operation_keyword] [parameters] [and/or] [values]

CLI 모드에서의 명령어를 검색하려면

	git help -a (--all)
	git help -g (--guides)
	git help -m (--man)
	git help -w (--web)
	git help -i (--info)
	git help remote : remote에 대한 내장 html 파일 열기
	git remote -help : remote에 대한 간단한 명령어 사용법

## Git 초기화
	cmd 창을 열고 해당 디렉토리까지 가서
	git init
init는 저장소를 초기화하는 명령어다.

백그라운드에서 일어난 일 (.git 디렉토리 생성)

	초기화 절차는 Workbench 디렉토리 하위에 .git 디렉토리를 생성한다.
	이 디렉토리는 사용자가 조작하거나 삭제하는 것을 방지하기 위해,
	깃에 의해 읽기전용(read-only) 이며 숨김(hidden) 상태로 생성된다.

	깃이 파일과 파일의 변경 이력에 대한 모든 내역을 보관하는 장소이기도 하다.
	삭제할 경우 디렉토리에 있는 파일들에 대한 내역들이 모두 사라져버리니
	.git 디렉토리를 조심해서 관리해야 한다.


## CLI모드에서 Git 설정
	git config --global user.name "your full name"
	git config --global user.email "your full email"
	git config --local user.name "your full name"
	git config --local user.email "your full email"

	를 입력하여 로컬과 글로벌의 이름과 이메일을 설정할 수 있다.

	확인하려면
	git config -l
	을 입력한다.

	어느 저장소에서든 파일들의 변경 사항들을 그룹 짓고 식별하기 위해,
	깃에서 사용하는 사용자 이름과 이메일 주소를 로컬 설정과 글로벌 설정에 각각 등록했다.

	config 명령은 깃의 설정을 등록할 때 사용된다.
	글로벌 설정은 시스템 사용자에 의해 생성된 모든 저장소에 대한 글로벌 값을 갖고
	로컬 설정은 정반대의 속성을 가진다.

	user.name 과 user.email 파라미터는 각 사용자의 이름과 이메일 주소를 기록한다.
	-l 파라미터로 깃의 모든 설정 값의 목록을 확인할 수 있다.

## Add
1. content.txt 파일을 만든 뒤 확인하려면
````
git status
````
2. content.txt 파일을 Add 하려면
````
git add content.txt
````

git status 명령은 저장소의 이전 상태와 달라진 변경 사항들을 알려달라는 명령어다.
git diff
명령으로 어떤 부분이 달라졌는지 알 수 있다.

git add .
을 하게 되면 GUI 모드에서 Ctrl+I 를 누른 것과 똑같으며
git add *.txt
라는 명령어를 쓸 수도 있다.


.gitignore 파일은 수동으로 만들어 준다.

## Commit
````
git commit -m "메세지"
````

이후 파일이 변경 되면 Rescan 과 git status 명령어로 확인하여 commit 하면 된다.


## Check Out
````bash
# Repository 의 이력을 조회한다.
git log 

git checkout <COMMIT_ID>
# git log를 통해 커밋ID 를 확인하고 커밋ID 5자 이상만 입력해 주어도 체크아웃 가능하다.

# 다시 master 브랜치로 돌아가려면
git checkout master
````

## Reset
Reset은 콘텐츠를 되돌릴 수 없는 Checkout 이라고 보면 된다.
````
git log
# Commit ID 확인

git reset --soft <COMMIT_ID>
````

### CLI모드에서 add 명령어 되돌리기
````bash
git reset context.txt
# 아래의 add 명령어와 반대되는, 되돌리는 명령이다.

git add context.txt
````

## 원격저장소의 커밋 취소하기
````
git reset --hard <COMMIT_ID>
git push -f origin master
````

## 원격저장소
````
git fetch : 소스부터 목적지까지의 변경 사항들을 가져오는 데 사용한다.
git merge : merge는 두개의 branch를 하나로 합치는 과정이다.
git pull : 실행하면 내부적으로 git fetch가 실행되고 뒤이어 git merge가 실행된다.
git push : 소스를 원격저장소로 밀어 넣는데 사용한다.
git remote : 소스와 목적지를 관리하는 데 사용한다.
			어디서 어떻게 작업 내용을 공유할 수 있는지와 반대의 경우를 알려준다.
			원격 연결을 이용해 데이터를 공유할 수 있는 명령이다.
			fetch, push, pull은 remote를 통해 제공된 원격 연결을 이용한다.
````

## 원격저장소 등록하기
1. 해당 저장소 디렉토리로 이동
2. git remote add <remove_name> <remote_url>
````bash
ex) git remote add origin https://galcyurio@bitbucket.org/galcyurio/online_workbench.git
````
해당 명령어는 url을 원격저장소로 등록하고 origin 이란 별칭을 주는 것이다.

### 원격저장소로 push하기
````bash
# origin 원격저장소에 master 브랜치 push하기
git push -u origin master
````
-u origin master 라는 파라미터는 원격 저장소에 push하거나 pull 할 때 사용하는 기본 branch를 지정하는데 사용한다.

````bash
# 어떤 branch가 기본으로 설정되었는지 확인하려면
git push -u
````

## clone 하기
````bash
git clone <repository> <directory>
````

origin/HEAD 란 원격저장소의 현재 브랜치의 가장 상위버전을 가리킨다.


## log 명령어로 커밋정보 검색하기
### shortlog 를 통해 짧은 커밋 정보를 얻기
	git shortlog


### log 를 통해 상세한 커밋 정보 얻기
	git log
	git show

### 날짜를 통해 정리하려면
	git log --since=2016-08-08 --until=2016-08-13


### 단어나 철자 검색
	git log --grep="Merge"


### 그래프를 통해 log 보기
	git log --graph

### 그래프, 데코레이션, 모든 로그, 한 줄로 보기
	git log --graph --decorate --all --oneline


## 파일 청소하기
### 로컬 저장소에 끼어든 파일 중 필요없는 파일 청소하기
````bash
git clean -f -e *.txt
# 깃이 버전관리하고 있는 파일을 모두 제거하고 *.txt 는 예외로 한다.
````


## credential.helper 설정
````bash
# 관리자 권한으로 접속 후 지우기
git config --system --unset credential.helper

# manager credential.helper 추가하기(관리자 권한으로 접속)
git config --system credential.helper manager
````

## 이미 commit 된 파일을 ignore 되게 하기
To untrack a single file that has already been added/initialized to your repository, i.e., stop tracking the file but not delete it from your system use: 
`git rm --cached filename`

To untrack every file that is now in your .gitignore:

First commit any outstanding code changes, and then, run this command:

	git rm -r --cached .

This removes any changed files from the index(staging area), then just run:

	git add .
Commit it:

	git commit -m ".gitignore is now working"



To undo

	git rm --cached filename
, use

	git add filename.


## remote repository 의 branch 생성하기
````bash
# 원칙적으로는 다음과 같음
git push <remote-name> <local-branch-name>:<remote-branch-name>

# 하나를 생략하면 remote branch 와 local branch 의 이름이 같다고 여긴다.
git push <remote-name> 
````

## remote repository 의 branch 삭제하기
````bash
git push origin :<remote-branch-name>

#또는
git push origin --delete <remote-branch-name>
````


##  gitconfig 파일 삭제
모종의 이유로 gitconfig 파일을 삭제할 경우가 생기게 된다면
`C:\Program Files\Git\mingw64\etc\gitconfig`
에서 삭제한다.

## Git 에 저장된 credential.helper 삭제하기 
1. 관리자 모드로 git bash 나 cmd 를 작동시킨다.
2. 해당 repo 에 가서
````
git config --system --unset credential.helper
git config --global --unset credential.helper
git config --local --unset credential.helper
````
를 통해서 credential.helper 를 모두 지워서 인증정보를 삭제시킨다.
