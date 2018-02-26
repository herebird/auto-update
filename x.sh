#!/bin/bash
myip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
myint=`ifconfig | grep -B1 "inet addr:$myip" | head -n1 | awk '{print $1}'`;

 red='\e[1;31m'
               green='\e[0;32m'
               NC='\e[0m'
			   
               echo "Connect ocspanel.info..."
               sleep 1
               
			   echo "กำลังตรวจสอบ Permision..."
               sleep 1
               
			   echo -e "${green}ได้รับอนุญาตแล้ว...${NC}"
               sleep 1
			   
flag=0

if [ $USER != 'root' ]; then
	echo "คุณต้องเรียกใช้งานนี้เป็น root"
	exit
fi

# initialisasi var
export DEBIAN_FRONTEND=noninteractive
OS=`uname -m`;

if [[ -e /etc/debian_version ]]; then
	#OS=debian
	RCLOCAL='/etc/rc.local'
else
	echo "คุณไม่ได้เรียกใช้สคริปต์นี้ในระบบปฏิบัติการ Debian"
	exit
fi

#INDEX.PHP
mkdir -p /var/www/html/Server
echo "<pre>#www.ocspanel.info - Facebook.com/ceolnw
<?php
//open connection to mysql db
	$connection = mysqli_connect("localhost","root","รหัสผ่าน phpmyadmin","SIAM ONLINE") or die("Error" .mysqli_error($connection));

//fetch table rows from mysql db
	$sql = "select * from table1";
	$result =  mysqli_query($connection, $sql) or die("Error in Selecting" .mysqli_error($connection));

//create an array
	$emparray = array();
	while($row =mysqli_fetch_assoc($result))
	{
		$emparray[] = $row;
	}
	echo json_encode($emparray);

//close the db connection
	mysqli_close($connection);
?></pre>" >/var/www/html/Server/index.php

#แก้ไขข้อมูลการเชื่อมต่อฐานข้อมูล phpmyadmin
nano /var/www/html/Server/index.php
