#!/bin/bash
domain=$(cat /etc/v2ray/domain)
uuid=$(cat /proc/sys/kernel/random/uuid)

cat <<EOF > /etc/trojan/config.json
{
    "log": {
        "loglevel": "warning"
    },
    "inbounds": [
        {
            "port": 30022,
            "protocol": "trojan",
            "settings": {
                "clients": [
                    {
                        "password":"${uuid}",
                        "email": "love@v2fly.org"
                    }
                ]
            },
            "streamSettings": {
                "network": "tcp",
                "security": "tls",
                "tlsSettings": {
                    "alpn": [
                        "http/1.1"
                    ],
                    "certificates": [
                        {
                            "certificateFile": "etc/v2ray/v2ray.crt",
                            "keyFile": "/etc/v2ray/v2ray.key"
                        }
                    ]
                }
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
EOF

cat <<EOF> /etc/systemd/system/trojan.service
[Unit]
Description=Trojan
Documentation=https://trojan-gfw.github.io/trojan/

[Service]
Type=simple
ExecStart=/usr/bin/v2ray -c /etc/trojan/config.json -l /var/log/trojan.log
Type=simple
KillMode=process
Restart=no
RestartSec=42s

[Install]
WantedBy=multi-user.target

EOF

cat <<EOF > /etc/trojan/uuid.txt
$uuid
EOF

