FROM ubuntu:latest
COPY . .
RUN apt-get update -y
RUN apt-get install -y man openjdk-8-jdk jq ffmpeg git tmux wget curl dialog
EXPOSE 8081
EXPOSE 25577
CMD bash ./main.sh