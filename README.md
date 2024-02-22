# docker_sample
Dockerfile 또는 Docker Compose 샘플 구현 및 테스트 겸용 레포지토리 입니다.

<br />

## docker build 명령어 레퍼런스
https://docs.docker.com/engine/reference/commandline/build/

<br />

## Dockerfile 작성 레퍼런스 
https://docs.docker.com/engine/reference/builder/#dockerfile-reference

<br />

## 네트워크 지정한 컨테이너의 호스트명
```컨테이너명.네트워크명```
```
docker run --name "my-container" --network "my-network" 이미지명:태그명
```
만약 위 명령어로 컨테이너를 실행했을 경우 동일한 네트워크에 한해서 "my-container.my-network" 호스트로 접근 가능

<br />

## docker compose 로 생성된 컨테이너명
```docker-compose.yml 파일의 상위 폴더명-서비스명-{숫자}```
이름을 지정하지 않았다면 위 규칙대로 이름 지어짐

<br />

## docker compose 로 생성된 컨테이너의 개인 호스트 주소
```컨테이너명.네트워크명```
yml 에 작성한 서비스명은 로드밸런스 같은 느낌이고, 같은 서비스명이지만 특정 컨테이너와 통신하고 싶다면 위 규칙에 맞는 호스트 주소로 통신하면 됨

<br />

## gitlab 루트 계정 초기 비밀번호 확인
```
vim /etc/gitlab/initial_root_password
```

<br />

## gitlab-runner 등록 방법 (레거시)
1. gitlab -> Admin Area -> Ci/CD -> Runners 으로 이동
2. New Instance runner 버튼 옆에 더보기 심볼 아이콘을 클릭 후 Registration token 을 복사해둠
3. gitlab 이 설치된 서버 터미널에서 아래 명령어를 실행
```
gitlab-runner register
```
4. 입력 프롬프트가 나올 때마다 상황에 맞게 입력
5. 설정 완료 후 gitlab-runner 시작 또는 재시작
```
gitlab-runner start
```
or
```
gitlab-runner restart
```
<br />

## gitlab-runner 등록 방법 (신규) 
1. gitlab -> Admin Area -> Ci/CD -> Runners 으로 이동
2. New Instance runner 버튼을 클릭해 러너를 관리자 콘솔 페이지에서 생성
3. 화면에 표시되는 명령어들을 터미널에 입력

<br />

또는 아래처럼 프로젝트 전용 러너를 따로 생성할 수도 있음. <br />

1. 레포지토리 -> Settings -> CI/CD -> Runners (Expand) -> New Project Runner 버튼 클릭

<br />

## gitlab-runner executer 를 docker 로 사용할 때 config.toml 수정 필요
1. vim /etc/gitlab-runner/config.toml
2. [runners.docker] 항목에서 아래 ```키=값``` 추가 및 변경
```
privileged = true
```
```
network_mode = "host"
```
3. gitlab-runner 재시작
```
gitlab-runner restart
```