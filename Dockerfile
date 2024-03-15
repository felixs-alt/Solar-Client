FROM ubuntu:latest
COPY . .
RUN apt-get update -y
RUN apt-get install -y man openjdk-8-jdk jq ffmpeg git tmux wget curl dialog
RUN yes N | apt install -y mysql-server-8.0
EXPOSE 8081
EXPOSE 25577
EXPOSE 3306
CMD bash ./main.sh
