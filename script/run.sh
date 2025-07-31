#!/bin/bash

APP_NAME=demo-0.0.1-SNAPSHOT.jar
APP_DIR=/home/ec2-user/app/build/libs
LOG_DIR=/home/ec2-user/app/log

DATE=$(date +"%Y%m%d")

LOG_FILE=$LOG_DIR/${DATE}-app.log

# 디렉토리 없으면 생성
if [ ! -d "$APP_DIR" ]; then
  echo "> 디렉토리가 존재하지 않아 생성합니다: $APP_DIR"
  mkdir -p "$APP_DIR"
fi

# 로그 디렉토리 없으면 생성
if [ ! -d "$LOG_DIR" ]; then
  echo "> 로그 디렉토리가 존재하지 않아 생성합니다: $LOG_DIR"
  mkdir -p "$LOG_DIR"
fi

echo "> 프로세스 종료 중..."
PID=$(pgrep -f $APP_NAME)

echo $PID

if [ -n "$PID" ]; then
  echo "> 기존 프로세스 종료: $PID"
  kill -15 $PID
  sleep 5
fi

echo "> 새 버전 실행"
cd $APP_DIR
nohup java -jar $APP_NAME > $LOG_FILE 2>&1 &
