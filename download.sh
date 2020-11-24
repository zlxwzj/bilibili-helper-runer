#!/bin/bash
version=$(wget -qO- -t1 -T2 "https://github.com/JunzhouLiu/BILIBILI-HELPER/releases/latest" | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g')

function installUnzip(){
  command -v apt >/dev/null 2>&1 && (apt-get update; apt-get install unzip -y; return;)
  command -v yum >/dev/null 2>&1 && (yum install unzip -y; return;)
}

function download(){
  wget -O "BILIBILI-HELPER.zip" "https://glare.now.sh/JunzhouLiu/BILIBILI-HELPER/BILIBILI-HELPER-v${1}.zip"
  command -v unzip >/dev/null 2>&1 || installUnzip
  unzip -o "BILIBILI-HELPER.zip" -d "."
  rm "BILIBILI-HELPER.zip"
  mv "BILIBILI-HELPER-v${1}.jar" "BILIBILI-HELPER.jar" -f
}

download $version
echo "下载完成"
