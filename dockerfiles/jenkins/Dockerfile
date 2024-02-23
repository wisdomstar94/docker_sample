# https://docs.docker.com/engine/reference/builder/

# 베이스가 되는 도커 이미지 지정
FROM --platform=linux/arm64 wisdomstar94/ubuntu-basic:0.0.1

# 파일 포함시키기
ADD --chmod=755 ./entrypoint.sh /home/entrypoint.sh
ADD --chmod=755 ./onece-exec /home/onece-exec

# jenkins 설치
RUN apt install -y openjdk-17-jdk gnupg
WORKDIR /tmp
RUN curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
RUN echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | tee /etc/apt/sources.list.d/jenkins.list > /dev/null
RUN apt update -y
RUN apt install -y jenkins

WORKDIR /home

# 컨테이너가 실행 중일 때 listen 할 포트 지정
EXPOSE 8080

# 컨테이너가 실행될 때 실행될 명령어 지정
ENTRYPOINT ["/bin/bash", "-c", "/home/entrypoint.sh && bash"]