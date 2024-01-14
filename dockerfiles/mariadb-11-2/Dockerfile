# https://docs.docker.com/engine/reference/builder/

# 베이스가 되는 도커 이미지 지정
FROM --platform=linux/arm64 wisdomstar94/ubuntu-basic:0.0.1

# 빌드시 받을 수 있는 인자 지정
ARG MARIADB_PORT=3306
ARG MARIADB_ROOT_PASSWORD=112233aB*

# 기본 ENV 값 셋팅
ENV MARIADB_ROOT_PASSWORD=$MARIADB_ROOT_PASSWORD

# mariadb 설치 및 기본 셋팅 (root 계정의 비밀번호 설정 및 사용자 추가 등)
RUN curl -LsS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | bash -s -- --mariadb-server-version=11.2
RUN apt-get -y install mariadb-server mariadb-client
# RUN service mariadb start \
#     && (echo ""; echo "Y"; echo "n"; echo "Y"; echo "n"; echo "Y"; echo "Y";) | mariadb-secure-installation 
    # && (echo "CREATE USER 'tester'@'localhost' identified by '$MARIADB_ROOT_PASSWORD';"; echo "exit";) | mariadb

# mariadb 기본 언어셋 UTF-8로 설정
RUN sed -i'' -r -e "/\[mariadb-client\]/a\default-character-set = utf8mb4" /etc/mysql/mariadb.conf.d/50-mariadb-clients.cnf \
    && sed -i'' -r -e "/\[mariadb-upgrade\]/a\default-character-set = utf8mb4" /etc/mysql/mariadb.conf.d/50-mariadb-clients.cnf \
    && sed -i'' -r -e "/\[mariadb-admin\]/a\default-character-set = utf8mb4" /etc/mysql/mariadb.conf.d/50-mariadb-clients.cnf \
    && sed -i'' -r -e "/\[mariadb-binlog\]/a\default-character-set = utf8mb4" /etc/mysql/mariadb.conf.d/50-mariadb-clients.cnf \
    && sed -i'' -r -e "/\[mariadb-check\]/a\default-character-set = utf8mb4" /etc/mysql/mariadb.conf.d/50-mariadb-clients.cnf \
    && sed -i'' -r -e "/\[mariadb-dump\]/a\default-character-set = utf8mb4" /etc/mysql/mariadb.conf.d/50-mariadb-clients.cnf \
    && sed -i'' -r -e "/\[mariadb-import\]/a\default-character-set = utf8mb4" /etc/mysql/mariadb.conf.d/50-mariadb-clients.cnf \
    && sed -i'' -r -e "/\[mariadb-show\]/a\default-character-set = utf8mb4" /etc/mysql/mariadb.conf.d/50-mariadb-clients.cnf \
    && sed -i'' -r -e "/\[mariadb-slap\]/a\default-character-set = utf8mb4" /etc/mysql/mariadb.conf.d/50-mariadb-clients.cnf

# mariadb port 변경
RUN sed -i'' -r -e "/user                    = mysql/a\port            = $MARIADB_PORT" /etc/mysql/mariadb.conf.d/50-server.cnf

# mariadb bind-address 를 0.0.0.0 으로 변경 (호스트OS에서 컨테이너의 mariadb에 HeidiSQL 같은 툴로 접근하기 위함)
RUN sed -i'' -r -e "s/bind-address/\# bind-address/" /etc/mysql/mariadb.conf.d/50-server.cnf \
    && sed -i'' -r -e "/bind-address            = 127.0.0.1/a\bind-address            = 0.0.0.0" /etc/mysql/mariadb.conf.d/50-server.cnf

# onece-exec 포함시키기
ADD --chmod=755 ./onece-exec /home/cli/onece-exec
ADD --chmod=755 ./mariadb-init.sh /home/cli/mariadb-init.sh
ADD --chmod=755 ./mariadb-always.sh /home/cli/mariadb-always.sh

# 컨테이너가 실행 중일 때 listen 할 포트 지정
EXPOSE $MARIADB_PORT

# 컨테이너가 실행될 때 실행될 명령어 지정
ENTRYPOINT ["/bin/bash", "-c", "/home/cli/onece-exec run --path='/home/cli/mariadb-inited.txt' --onece='sh /home/cli/mariadb-init.sh' --always='sh /home/cli/mariadb-always.sh'; /bin/bash"]
