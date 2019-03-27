# 인증서 서명 정보 분리

> Before uploading the updated application, be sure that you have incremented the android:versionCode and android:versionName attributes in the element of the manifest file. Also, the package name must be the same and **the .apk must be signed with the same private key.** If the package name and signing certificate do not match those of the existing version, Market will consider it a new application and will not offer it to users as an update.

## 필수로 행해야 하는 작업들

1. git 저장소에서 keystore 파일을 제거
  - `git filter-branch` 명령어를 통해서 이전 목록에서 keystore 파일 완전 제거
  - 원격 저장소에 `git push --all --force` 명령어를 통해 강제로 push하여 원격 저장소에서도 keystore 파일 완전 제거
2. 비밀번호 변경하고 어딘가에 따로 저장하지 않고 기억해두기
  - keystore 비밀번호 변경
  - 앱 서명에 사용하는 key 비밀번호 변경
3. 로컬에 남아있는 keystore 모두 제거

## 민감 파일 분리 방법

- 직접 APK 서명 (keystore 파일 백업본 필요)
  - keystore만 로컬에 보관하고 릴리즈용 apk 하나에만 apksigner를 통해서 비밀번호를 입력하여 수동으로 서명
    - https://developer.android.com/studio/publish/app-signing?hl=ko#sign-manually
    - android open source project 에서 만들어진 find_java.bat 파일이 zulu를 감지하지 못해서 Oracle JDK 설치해야 함
    - apksigner가 제대로 동작하는지 확인해보아야함
  - Properties 파일로 분리
- Google Play 앱 서명 사용
  - https://developer.android.com/studio/publish/app-signing?hl=ko#google-play-app-signing
  - 업로드 키로 업로드하고, 구글에서 서명키를 관리하고 앱에 서명까지
  - 업로드 키를 분실하거나 키가 손상된 경우 구글에 연락하면 새 키를 생성 가능