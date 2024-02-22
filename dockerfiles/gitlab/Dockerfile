# https://docs.docker.com/engine/reference/builder/

# 베이스가 되는 도커 이미지 지정
FROM --platform=linux/arm64 wisdomstar94/ubuntu-basic:0.0.1

# 빌드시 받을 수 있는 인자 지정
ARG PORT=8081
ARG ROOT_PASSWORD=123123aB*

# 기본 ENV 값 셋팅
ENV ROOT_PASSWORD=$ROOT_PASSWORD
ENV NODE_VERSION=20.11.1

# 파일 포함시키기
ADD --chmod=755 ./entrypoint.sh /home/entrypoint.sh
ADD --chmod=755 ./init.sh /home/init.sh
ADD --chmod=755 ./onece-exec /home/onece-exec

# SHELL ["/bin/bash", "--login", "-c"]

# node.js 셋팅
RUN /bin/bash -c "source $NVM_DIR/nvm.sh && nvm install $NODE_VERSION && nvm use $NODE_VERSION && nvm alias default $NODE_VERSION"
# RUN nvm install v20.11.1 
# RUN nvm use 20.11.1 
# RUN nvm alias default 20.11.1

# gitlab 설치를 위한 필요 패키지들 설치
RUN apt update -y && apt upgrade -y
RUN apt install -y ca-certificates curl openssh-server

# gitlab install
RUN cd /tmp \
    && curl -LO https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh \
    && dpkg --configure -a \
    && (echo "\n"; echo "1";) | bash /tmp/script.deb.sh \
    && apt-get install gitlab-ce -y

# gitlab 설정 변경
RUN sed -i'' -r -e "s@external_url 'http://gitlab.example.com'@external_url 'http://localhost:$PORT'@" /etc/gitlab/gitlab.rb

# gitlab runner 설치 
RUN curl -L --output /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-arm64
RUN chmod +x /usr/local/bin/gitlab-runner 
RUN useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash 
RUN gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner

# gitlab runner 가 구동될 환경을 위해 docker 설치
RUN apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common 
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository "deb [arch=arm64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
RUN apt-get clean
RUN apt-get update -y 
RUN apt-get install -y docker-ce docker-ce-cli

# 컨테이너가 실행 중일 때 listen 할 포트 지정
EXPOSE $PORT
EXPOSE 22

# 컨테이너가 실행될 때 실행될 명령어 지정
ENTRYPOINT ["/bin/bash", "-c", "/home/entrypoint.sh"]