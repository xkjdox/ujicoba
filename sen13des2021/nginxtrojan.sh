server {
    listen ${webport};
    server_name ${domain};
    root ${web_dir};
    ssl on;
    ssl_certificate   /data/${domain}/fullchain.crt;
    ssl_certificate_key  /data/${domain}/${domain}.key;
	  ssl_ciphers                 TLS13-AES-256-GCM-SHA384:TLS13-CHACHA20-POLY1305-SHA256:TLS13-AES-128-GCM-SHA256:TLS13-AES-128-CCM-8-SHA256:TLS13-AES-128-CCM-SHA256:EECDH+CHACHA20:EECDH+CHACHA20-draft:EECDH+ECDSA+AES128:EECDH+aRSA+AES128:RSA+AES128:EECDH+ECDSA+AES256:EECDH+aRSA+AES256:RSA+AES256:EECDH+ECDSA+3DES:EECDH+aRSA+3DES:RSA+3DES:!MD5;
    ssl_prefer_server_ciphers    on;
    ssl_protocols                TLSv1 TLSv1.1 TLSv1.2 TLSv1.3;
    ssl_session_cache            shared:SSL:50m;
    ssl_session_timeout          1d;
    ssl_session_tickets          on;
}
EOF
