#!/bin/bash
version=$(wget -qO- -t1 -T2 "https://api.github.com/repos/JunzhouLiu/BILIBILI-HELPER/releases/latest" | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g;s/V//g')

wget -O "BILIBILI-HELPER.zip" "https://github.com/JunzhouLiu/BILIBILI-HELPER/releases/download/V${version}/BILIBILI-HELPER-v${version}.zip"
mkdir "jar"
unzip -o "BILIBILI-HELPER.zip" -d "./jar/"
mv "./jar/BILIBILI-HELPER-v${version}.jar" "./jar/BILIBILI-HELPER.jar" -f
mv "./config.json" "./jar/config.json" -f
rm "BILIBILI-HELPER.zip"

echo "下载完成"
