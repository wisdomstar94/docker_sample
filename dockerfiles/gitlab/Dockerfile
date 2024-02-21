# https://docs.docker.com/engine/reference/builder/

# 베이스가 되는 도커 이미지 지정
FROM --platform=linux/arm64 wisdomstar94/ubuntu-basic:0.0.1

# 빌드시 받을 수 있는 인자 지정
ARG PORT=8081
ARG ROOT_PASSWORD=123123aB*

# 기본 ENV 값 셋팅
ENV ROOT_PASSWORD=$ROOT_PASSWORD

# 파일 포함시키기
ADD --chmod=755 ./entrypoint.sh /home/entrypoint.sh
ADD --chmod=755 ./root-password-change.sh /home/root-password-change.sh
ADD --chmod=755 ./onece-exec /home/onece-exec

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

# gitlab 루트 계정 초기 비밀번호 확인
# vim /etc/gitlab/initial_root_password

# gitlab 설정 변경사항 적용
# RUN (echo "";) | /opt/gitlab/embedded/bin/runsvdir-start & > /dev/null
# RUN gitlab-ctl reconfigure

# 컨테이너가 실행 중일 때 listen 할 포트 지정
EXPOSE $PORT

# 컨테이너가 실행될 때 실행될 명령어 지정
ENTRYPOINT ["/bin/bash", "-c", "/home/entrypoint.sh"]