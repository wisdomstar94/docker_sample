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