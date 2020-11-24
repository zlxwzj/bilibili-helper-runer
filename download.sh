#!/bin/bash
version=$(wget -qO- -t1 -T2 "https://api.github.com/repos/JunzhouLiu/BILIBILI-HELPER/releases/latest" | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g;s/V//g')

wget -O "BILIBILI-HELPER.zip" "https://glare.now.sh/JunzhouLiu/BILIBILI-HELPER/BILIBILI-HELPER-v${version}.zip"
command -v unzip >/dev/null 2>&1 || installUnzip
unzip -o "BILIBILI-HELPER.zip" -d "."
rm "BILIBILI-HELPER.zip"
mv "BILIBILI-HELPER-v${version}.jar" "BILIBILI-HELPER.jar" -f

echo "下载完成"
