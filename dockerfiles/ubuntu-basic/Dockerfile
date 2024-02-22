# https://docs.docker.com/engine/reference/builder/

# 베이스가 되는 도커 이미지 지정
FROM --platform=linux/arm64 ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

# 기본 ENV 값 셋팅
ENV TZ=Asia/Seoul
ENV LC_ALL=ko_KR.UTF-8
ENV NVM_DIR=/usr/local/nvm

# 필요 패키지 설치
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install vim curl net-tools telnet iputils-ping wget git -y

# 한글 UTF-8 언어팩 설치 및 적용
# 언어셋이 ko_KR.UTF-8 로 설정됨
RUN apt-get install locales -y \
    && localedef -f UTF-8 -i ko_KR ko_KR.UTF-8

# 타임존 설정 (6. Asia / 69. Seoul)
RUN apt-get install tzdata -y

# nvm 설치
RUN mkdir /usr/local/nvm
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash 

