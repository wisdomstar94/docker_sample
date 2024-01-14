# https://docs.docker.com/engine/reference/builder/

# 베이스가 되는 도커 이미지 지정
FROM --platform=linux/arm64 wisdomstar94/ubuntu-basic:0.0.1

# https://docs.docker.com/engine/reference/builder/#add
# 본 Dockerfile 이 빌드가 진행되고 있는 PC의 특정 파일 또는 폴더를 본 이미지 안의 특정 경로에 포함
# ADD 로 추가하는 파일의 경로는 Dockerfile 이 위치하고 있는 경로와 같은 경로에서 시작되어야 함
RUN groupadd -g 90147 mygroup
RUN useradd -g 90147 myuser
ADD --chown=myuser:mygroup --chmod=655 ./files/test.txt /home/project/a/b/my-file.txt 
ADD --chown=myuser:mygroup --chmod=655 ./files/ /home/project/c/files/

