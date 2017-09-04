# GitHub

## SSH Key 설정
GitHub는 작성한 저장소에 대한 접근 인증을 ssh 공개 키로 한다.
1. Git Bash 접속
2. ssh-keygen -t rsa -C "galcyurio@gmail.com"
3. 파일 경로 나오면 엔터
4. 비밀번호 2번 입력


### 공개키 등록
`GitHub Settings` - `Account` - `SSH Keys` - `Add SSH Keys`

Key 칸에 id_rsa.pub 의 내용을 복사해서 붙여 넣어 준다.
(`cat ~/.ssh/id_rsa.pub`)
처음부터 이메일까지 모두 다 넣어준다.

등록이 끝나면 이메일이 발송된다.
ssh -T git@github.com 
을 써서 실제로 동작하는지 확인한다.


## 파일 관련 조작
	파일을 클릭하고 들어가면 파일 내용이 표시되고 파일과 관련된 메뉴가 나온다.
	Raw : 해당 파일의 데이터를 웹 브라우저에 곧바로 표시한다.
			이때 웹 브라우저의 주소를 사용하면 해당 파일을 다운로드 할 수 있다.
	Blame : 파일과 과련된 정보들을 확인할 수 있음
	History : 파일의 변겨 내역을 환인 할 수 있음
	연필 모양 : 파일을 수정 할 때 사용, 자동으로 commit 된다.
	휴지통 모양 : 파일을 삭제



## Issue
Issue 는 소프트웨어 개발에 관련된 버그 또는 논의 등을 추적해서 관리하고자 만든 것
Issue 는 다음과 같은 상황에서 활용할 수 있다.
- 소프트웨어에서 버그를 발견해서 보고하려는 경우
- 리포지토리의 관리자에게 상담 또는 문의를 하는 경우
- 이후에 만들 기능을 적어 두는 경우

GitHub의 Issue와 댓글은 GFM 이라 불리는 형식으로 작성된다.

### __`글자 크기 조절`__
<pre>
# h1
## h2
</pre>

### __`Syntax Highlight`__
<pre>
````java
public static void main(String[] args){

}
````


```` 다음에 언어를 적어 주고 
```` 로 닫으면 된다.
</pre>

### __`그림 첨부`__
GFM을 작성하고 있는 부분에 그림 파일을 드래그&드롭하면 그림이 첨부된다.
또한 아래쪽에 있는 'selecting them' 을 클릭해도 된다.


### __`라벨 붙이기`__
Issue 는 라벨을 붙여서 정리할 수 있다.
라벨을 붙이면 Issue 옆에 라벨이 표시된다.
Issue 옆의 라벨을 클릭하면 라벨이 붙어 있는 Issue 만 표시된다.

체크박스를 선택하고 Labels 에서 붙이고 싶은 라벨을 붙이면 된다.
라벨을 새로 만들거나 수정해서 쓸 수도 있다.


### __`Miliestones`__
	위 메뉴에서 Milestones 를 클릭하여 새로 만들 수 있으며
	선택 메뉴에서 Milestones 를 클릭하여 원래 있던 Issue 를 추가할 수도 있다.


### __`할 일 목록 만들기`__
	GFM 은 독자적으로 할 일 목록을 만들 수 있다.
	# Today
	- [ ] make image
	- [x] setting deploy
	- [ ] make someting


### commit 메시지로 Issue 조작
	- GitHub는 특정한 형식으로 commit 메시지를 작성해서 Issue를 조작할 수 있다
	
	Issue 목록을 보면 제목의 오른쪽에 '#1' 과 같이 번호가 붙어 있다.
	이 번호는 모든 Issue에 할당 된다.
	
	그리고 commit 메시지를 작성할 때 '#1' 이라는 번호를 붙여주면
	1번 Issue 와 관련된 commit 이라는 정보가 표시된다.
	git commit -m "실험 #1"
	
	이렇게 자성하면 한 번 클릭하는 것 만으로 고나련된 Issue를 모두 확인 할 수 있다.
	따라서 코드 리뷰 등을 할 때 commit 을 따로 찾는 수고를 들이지 않아도 된다.


### Issue 를 close 하기
	Open 되어 있는 Issue 의 대응이 끝나는 commit 은 다음과 같은 형식으로
	commit 메시지를 작성하면 해당 Issue가 자동으로 close 된다.
	
	fix #1
	fixes #1
	fixed #1

	close #1
	closes #1
	closed #1

	resolve #1
	resolves #1
	resolved #1

	이런 형태로 commit 메시지를 활용하면 push 이후에 직접 issue를 찾아가 close 버튼을 누르지 않아도 된다.


특정 Issue 를 Pull Request로 변환
	Issue에 소스 코드를 넣어 주면 Pull Request 로 변환 된다.
	Issue 번호와 Pull Request 번호는 동일하다.


## Pull Request 
Pull Request는 자신이 변경한 코드를 상대방의 리포지토리에 넣고 싶을 때 사용하는 기능
GitHub에서 가장 중요한 기능이다.
Pull Request 기능을 잘 활용해야 오픈 소스 소프트웨어를 개발할 때 많은 사람이 함께 협업하기 쉽다.

GitHub 에서 Pull Request 를 보내면 해당 리포지토리의 소스 코드에 Issue 가 만들어 진다.
이 Issue에 상세 내용을 입력한다.
이것이 바로 Pull Request 이다.

이렇게 하면 해당 리포지토리의 관리자가 보내진 Pull Request를 반영할지 말지를 판단한다.
본인이 제출한 Pull Request가 해당 리포지토리의 문제를 해결한 것으로 받아들여지면
본인은 해당 프로젝트의 contributor가 된다.


## __`Pull Request 보내기`__
1. 리포지토레 페이지에 접속해서 Fork 를 한다.
2. 자신의 개발환경에서 리포지토리를 clone한다.
3. 해당파일을 수정하고 commit 한다.
4. GitHub에 수정된 브랜치를 push해준다.
5. 자신의 원격저장소에 들어가서 Pull request 클릭
6. New Pull Request
7. base와 fork의 branch를 잘 설정해주고 Create pull request
8. 이후 어떠한 것인지 자세한 내용을 적어주면 된다.


## __`Pull Request 받기`__
1. Pull Request 를 받았다면 수신자의 로컬 리포지토리를 pull하여 최신 상태로 변경한다.
2. 송신자의 리포지토리를 원격 리포지토리로 등록한다.
	git remote add PR송신자 git@github.com:PR수신자/first-pr.git
	git fetch PR송신자
	이렇게 Pull Request 송신자 리포지토리, 또는 브랜치의 데이터(PR송신자/work)를 취득한다.
3. 확인 전용 브랜치를 생성하고 merge한 뒤 확인 전용 브랜치를 삭제한다.
	git merge PR송신자/work
4. 이 시점에서 로컬 리포지토리에서 문제가 없다면 브라우저에서 Merge pull reqeust를 해도 된다.
	또한 수동으로 push를 해도된다.


## __`본인의 repository 에서 pull request 주고 받기`__
1. 파일을 변경하고 브랜치를 생성한다.
2. pull request 를 보낸다.
3. 로컬 저장소에서 확인 전용으로 브랜치를 하나 생성 후 merge 한다.
4. 이상 없을 시 master 브랜치에서 merge 하거나 브라우저에서 merge 한다.


pull request가 개발 중임을 알리려면 앞에  [WIP] 라는 글자를 삽입한다.
Work In Progress 의 약자이며 현재 작업 중이라는 것을 표명한다.
구현이 완료된 이후에는 이 글자를 지워준다.


diff 또는 patch 파일 형식 활용
Pull Request 의 URL 형식

https://github.com/사용자이름/리토지토리이름/pull/28

이러한 Pull Request를 diff 파일 형식으로 얻으려면 다음과 같이 URL 뒤에 .diff 를 추가한다.
https://github.com/사용자이름/리토지토리이름/pull/28.diff

마찬가지로 patch파일 형식으로 얻으려면 다음과 같이 URL 뒤에 .patch를 추가한다.
https://github.com/사용자이름/리토지토리이름/pull/28.patch



Conversation 탭에서는 해당 Pull Request 에 관련된 댓글과
commit 이력을 확인 할 수 있다.

## __`Wiki`__
Wiki는 간단한 문법으로 문서를 작성 또는 편집할 수 있는 기능이다.
리포지토리 작성 권한이 있는 사람이라면 누구나 Kiki 를 사용할 수 있으므로
공동으로 작업할 때 편리하게 이용된다.
또한 웹 브라우저에서 곧바로 작성 또는 편집할 수도 있다.

마찬가지로 GFM 으로 작성 가능하다.

Wiki 기능으로 작성하는 페이지도 Git으로 관리된다.
오른쪽의 Clone URL 버튼을 누르면 Wiki 리포지토리 URL 이 복사된다.
복사된 RUL 로 clone 하면 GitHub에 있는 Wiki 리포지토리를 로컬 리포지토리로 옮길 수 있다.
이후에 로컬에서 페이지를 수정하고 push해서 Wiki를 작성하거나 수정할 수 있다.


revisions가 붙은 글자 태그를 클릭하면, Wiki의 변경내역을 확인 할 수 있다.
작업 실수를 해도 과거 상태로 되돌릴 수 있으므로 안심하고 작업해도 된다.
또한 자신의 컴퓨터에 clone하면 웹 브라우저 외에도 평소에 사용하는 에디터로 편집할 수 있다.

일반적으로 Wiki에는 소프트웨어와 관련된 FAQ, 문서, 샘플코드, 설명 등을 정리한다.


## __`Pulse`__
Pulse 는 소프트웨어가 얼마나 활발하게 개발되고 있는지 확인 할 수 있는 기능이다.
Pull Request, Issue 등이 얼마나 많이 작성되고 있는가 등의 정보를 한 눈에 볼 수 있다.



## __`Graphs`__
Graphs 에서는 리포지토리와 관련된 통계 정보를 네 종류의 그래프로 확인할 수 있다.

## __`Contributors`__
Contributors 에서는 어떤 사용자가, 언제, 얼마만큼 코드를 추가 또는 삭제했는지
그래프로 알아볼 수 있다.
또한 그래프를 보면 어떤 사람이 리포지토리 개발을 이끌고 있는지 리포지토리의 스프트웨어가
언제 격변하는지 언제 안정적인 상태로 들어갔는지도 알 수 있다.
추가로 그래프에는 Pull Request를 보내고 확인한 코드의 추가와 삭제도 포함되어 있다.


### Commit Activity
	Commit Activity에서는 일주일 단위로 얼마나 많은 commit 이 발생했는지 그래프로 표시된다.


### Code Frequency
	코드줄의 증가와 감소를 그래프로 살펴 볼 수 있다.


### Punchcard
	무슨 요일, 몇 시에 commit 이 활발하게 일어났는지 알 수 있다.
	검은 동그라미가 클수록 commit 이 활발하게 일어났다는 뜻이다.
	

### Network
	Fork 된 리포지토리까지 포함해서 모든 브랜치 관계를 그래프로 나타내 준다.
	누가 얼마나 작업했는지 확인하고 싶을 때 보면 유용하다.
	또한 그래프에서 commit 또는 merge 되는 지점에 마우스를 올리면 관련 정보가 표시된다.


### members 
	현재 리포지토리 개발에 참여하고 있는 사람들의 목록이 나온다.



## __`Settings`__
리포지토리와 관련된 전반적인 설정을 할 수 있는 페이지이다.
설정 변경 권한이 있는 경우에만 표시된다.

## Options
### Settings
	리포지토리의 이름을 변경 할 수 있다.

### Features
	Wiki 또는 Issue와 관련된 설정을 변경할 수 있다.
	체크박스의 체크를 해제하면, 각각의 기능이 메뉴에서 제거되어 더는 이용할 수 없게 된다.
	필요치 않은 기능은 체크를 해제해두면 된다.

	
### GitHub Pages
	리포지토리에 등록되어 있는 파일들을 활용해 웹 페이지를 작성하는 기능이다.
	이를 활용하면 리포지토리에서 개발하고 있는 소프트웨어와 관련된 웹 사이트를 만들어 공개할 수 있다.
	이미 GitHub Pages 를 작성해서 사용하고 있다면 해당 부분에 URL이 표시된다.
	Automatic Page Generator 를 누르면 GitHub Pages 가 자동으로 작성된다.


### Danger Zone
	위험한 버튼들이 들어 있는 부분이다.
	리포지토리를 비공개 리포지토리로 변경하거나
	리포지토리의 소유자를 변경, 또는 삭제하는 경우에 사용한다.
	다른 사람들에게도 영향을 줄 수 있는 부분이므로 주의해서 설정해야 한다.



### Collaborators
	Collaborators 에서는 리포지토리의 접근 권한을 설정할 수 있다.
	일반 사용자 계정으로 작성한 리포지토리의 경우 
	다른 사용자 이름을 직접적으로 추가해서 해당 사용자에게 접근 권한을 부여한다.

	반면 리포지토리가 Organization 계정에 속해 있는 경우에는
	Team을 작성하고 작성한 Team에 대응되는 리포지토리를 기입 또는 확인 할 수 있는 권한이 부여된다.


### Webhooks & Services
	이 화면에서는 GitHub 리포지토리와 다른 서비스를 연동하기 위한 hook 설정을 한다.
	Add webhook 으로 독자적인 webhook 을 등록할 수 있다.
	Add servie 버튼을 누르면 GitHub와 연동할 수 있는 서비스 목록이 나온다.
	

### Deploy Keys
	이 화면에서는 Deploy를 위한 읽기 전용 공개 키를 등록할 수 있다.
	공개 키를 설정하면 설정한 키를 사용해 SSH 프로토콜로 clone등의 작업을 수행할 수 있다.
	주의 점은 여기서 등록한 공개 키와 비밀 키는 다른 리포지토리에서 사용할 수 없다.
	따라서 Deploy Keys 기능을 활용할 때는 리포지토리마다 공개 키와 비밀키를 별도로 관리해야 한다.



## GitHub 를 사용하는 경우의 개발 진행 과정

### GitHub Flow의 흐름
1. 새로운 작업을 수행할 때는 로컬 리포지토리에 master 브랜치에서 새로운 브랜치를 작성한다.
	이때, 새로운 브랜치의 이름은 무슨 작업을 할지 알 수 있도록 자세히 적는다.
	galcyurio-db-task-1
2. 코딩을 하고 로컬 리포지토리의 브랜치에 commit 을 수행한다. pull request 를 리뷰하는 다른 개발자를 위해 의도가 명확히 전달될 수 있도록 commit 은 작업별로 나누어서 commit 한다.
3. 같은 이름의 브랜치를 원격 리포지토리에 만들고, 해당 리포지토리에 주기적으로 push한다. 토픽 브랜치에서도 주기적으로 통합 브랜치를 merge 해준다.
4. 도움을 주거나 피드백을 원할 때에는 Pull Request를 주고 받는다.
5. 다른 개발자가 리뷰하고 작업 종료를 확인하면 master 브랜치에 통합한다.
	토픽 브랜치에서 작업하던 것이 완료되면 pull request를 통해 다른 개발자들에게 개발이 완료됬다고 알려준다. 그 후 다른 개발자들이 동의하면 통합 브랜치로 merge한다.
