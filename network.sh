#!/bin/bash

#适用于使用Linux的无上网客户端的在校大学生
#开一台Windows虚拟机，设置网络桥接模式，在虚拟机中联网，然后运行本脚本
#此脚本需要在root权限下运行，需手动在代码中填入Linux物理机的网卡名和虚拟机主机的MAC地址

#填入Linux物理机网卡名（默认enp4s0f1）
nc="enp4s0f1"

#填入你的虚拟机的MAC地址
MAC="08:00:27:C8:B5:73"

#获取虚拟机的IP地址
echo -e "请输入虚拟机的IP地址: \c "
read ipaddress

#获取Linux主机的IP地址
my_ip=`ifconfig $nc | grep 'inet 地址' | cut -d : -f 2 | cut -d ' ' -f 1`


ip link set $nc address $MAC
ip add add $ipaddress dev $nc
ip add del $my_ip dev $nc

#测试网络是否连通
pingres=`ping -c 1 baidu.com | sed -n '/64 bytes from/p'`  
if [ -z "$pingres" ]  
then  
        echo "失败，原因：1.虚拟机和Linux的主机不在同一网段 2.虚拟机MAC地址错误"   
        exit 1  
else
	echo "成功，可以上网了"
fi  





