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

## 저장소 만들기
````
GUI 모드에서 초기화(디렉토리를 저장소로 지정하는 절차)
Git GUI - Create new Repository
디렉토리 지정
````

## GUI 모드에서의 영역설명
	Unstaged Changes Pane : 언스테이지 변경 영역(좌측 상단)
	Staged Changed Pane : 스테이지 변경 영역(좌측 하단)
	Differential Content Pane : 컨텐츠 차이점 영역(우측 상단)
	Action Pane : 활동 영역(우측 하단)


## CLI 모드에서 초기화(디렉토리를 저장소로 지정하는 절차)
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


## 깃 설정(이름과 이메일 등록)
### GUI모드에서 깃 설정
1. 초기화 절차를 마친 화면에서 Edit 메뉴의 Options를 선택한다. 설정 화면은 다음과 같은 두 개의 역역으로 구분된다.
````
로컬 성정 : 왼쪽, GUI_Workbench 저장소에 한정된 설정
글로벌 설정 : 오른쪽, 설치된 깃을 사용하는 저장소에 적용되는 설정
````
2. 로컬과 글로벌 양쪽에 있는 이름과 이메일을 입력하고 Save 버튼을 누른다.


## CLI모드에서 깃 설정
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


## Add (Unstaged에서 Staged로 넘기기)
### GUI 모드에서 Add
	1. 아무 파일이나 만든 다음 우측 하단 Action 영역에서 Rescan 버튼을 누른다.(F5)
	2. Unstaged changes 영역에 있는 파일명 옆에 있는 아이콘을 클릭하면 Staged changes 영역으로 파일이 이동된다.
	Ctrl+I 를 누르게 되면 한번에 할 수 있다.


### CLI 모드에서 Add
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


## Add 되돌리기(Reset)
GUI 모드 에서는 좌측 아이콘을 클릭하면 된다.
````
git reset 파일이름.확장자
````

## Commit
### GUI 모드에서 Commit
1. Action 영역에서 Commit Message 를 입력
2. Commit 클릭


### CLI 모드에서 Commit
````
git commit -m "메세지"
````

이후 파일이 변경 되면 Rescan 과 git status 명령어로 확인하여 commit 하면 된다.


## Check Out
### GUI 모드에서 체크아웃
1. Repository - Visualize All Branch History 를 눌러서 gitk 를 실행
2. gitk 는 저장소에 관한 tagging, reset 등과 같은 다양한 종류의 명령을
	시각적으로 처리할 수 있는 그래픽 저장소 브라우저이다.
3. 해당 커밋을 선택하고 SHA1 ID 영역의 commit id 를 복사한다.
4. GIt GUI - Branch - Checkout (Ctrl+O)
5. Revision Expression 항목에 SHA1 ID 를 붙여넣고 Checkout 버튼 클릭

	다시 돌아가고 싶다면 <br/>
	Branch - Checkout - Localbranch - master브랜치 선택 - Checkout


### CLI 모드에서 체크아웃
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

### GUI 모드에서 Reset
````
gitk 에서 돌아가려는 버전에 우클릭 Reset 하면 된다.
바로 갱신되지 않으니 새로고침 하면된다.
````

### CLI 모드에서 Reset
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

## CLI모드에서 원격저장소 등록하기
1. 해당 저장소 디렉토리로 이동
2. git remote add <remove_name> <remote_url>
````bash
ex) git remote add origin https://galcyurio@bitbucket.org/galcyurio/online_workbench.git
````
해당 명령어는 url을 원격저장소로 등록하고 origin 이란 별칭을 주는 것이다.

### CLI모드에서 원격저장소로 push하기
````bash
# origin 원격저장소에 master 브랜치 push하기
git push -u origin master
````
-u origin master 라는 파라미터는 원격 저장소에 push하거나 pull 할 때 사용하는 기본 branch를 지정하는데 사용한다.

````bash
# 어떤 branch가 기본으로 설정되었는지 확인하려면
git push -u
````

## CLI모드에서 clone 하기
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
	git push origin :<remote-branch-name>


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
