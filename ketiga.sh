#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"
IZIN=$( curl https://raw.githubusercontent.com/xkjdox/rijrekeksdpdolwoqkqkakodix/main/Nxbdjekkwso.txt | grep $MYIP )
if [ $MYIP = $IZIN ]; then
echo -e "${green}Permission Accepted${NC}"
else
echo -e "${red}Permission Denied!${NC}";
echo "Only For Premium Users"
exit 0
fi
clear
source /var/lib/premium-script/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/v2ray/domain)
else
domain=$IP
fi
xtls="$(cat ~/log-install.txt | grep -w "Vless TCP XTLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "User: " -e user
		CLIENT_EXISTS=$(grep -w $user /usr/local/etc/xray/config1.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			exit 1
		fi
	done
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`

sed -i '/#tcpxtls$/a\### '"Client $user $exp"'\
{"id": "'""$uuid""'","flow": "'""xtls-rprx-direct""'","email": "'""$user""'"},' /usr/local/etc/xray/config1.json

vlesslink3="vless://${uuid}@${MYIP}:$xtls?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-direct&sni=YourISPBug#vless_xtls_${user}"
chmod 644 /etc/xray/xray.key
systemctl restart xray
clear
echo -e ""
echo -e "===========-XRAY/VLESS-=========="
echo -e "Remarks        : ${user}"
echo -e "IP             : ${MYIP}"
echo -e "Port XTLS      : $xtls"
echo -e "id             : ${uuid}"
echo -e "Encryption     : none"
echo -e "Flow           : xtls-rprx-direct"
echo -e "Network        : tcp"
echo -e "Security       : xtls"
echo -e "Allow Insecure : enable"
echo -e "================================="
echo -e "XRAY XTLS      : ${vlesslink3}"
echo -e "================================="
echo -e "Expired On     : $exp"
