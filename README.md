# NGINX - Enable Real IPs for Vistors using ngx_http_realip_module module.

# Installation
`1.` First, navigate to your nginx conf.d directory `cd /etc/nginx/conf.d`.\
`2.` Download the script to generate the config `sudo wget https://raw.githubusercontent.com/LubricantJam/Cloudflare-NGINX-Real-IP/master/update-cloudflare-ips.sh`.\
`3.` Run the script once manually to generate the .conf and then nano to make sure contents are generated properly `sudo sh update-cloudflare-ips.sh && nano cloudflare-real-ips.conf`.

# Automation

As Cloudflare may update IP ranges, it is advised to create a weekly cronjob to ensure all blocks are up-to-date.\
Before using a cronjob, ensure the permissions on the file are set to be executable: `chmod +x update-cloudflare-ips.sh`. \
`@weekly /bin/bash /etc/nginx/conf.d/cloudflare-ddns-script.sh`