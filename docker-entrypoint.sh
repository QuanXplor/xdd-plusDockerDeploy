#!/bin/sh

CODE_DIR=/xdd-plus

if [ "$ENABLE_GITHUBPROXY" = "true" ]; then
   GITHUBPROXY=https://ghproxy.com/
   echo "启用 github 加速 ${GITHUBPROXY}"
else
  echo "未启用 github 加速"
fi

if [ -z $REPO_URL ]; then
  REPO_URL="${GITHUBPROXY}${REPO_ADDRESS}"
fi


if [ ! -d $CODE_DIR/.git ]; then
  echo "xdd-plus 核心代码目录为空, 开始clone代码..."
  git clone $REPO_URL  $CODE_DIR
  wget -O $CODE_DIR/qbot/config.yml https://github.com/764763903a/xdd-plus/releases/download/v1.7/config.yml
else 
  echo "xdd-plus 核心代码已存在"
  echo "更新 xdd-plus 核心代码"
  cd $CODE_DIR && git config --global --add safe.directory /xdd-plus && git reset --hard && git pull
fi

if [ -f "./xdd-plus" ]; then
  rm -rf ./xdd-plus
fi
go build -buildvcs=false -o ./xdd-plus
chmod +x ./xdd-plus


echo "启动..."
 ./xdd-plus
