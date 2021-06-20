# Shell Script To Update Cloudflare IP Addresses.
# Tested on Ubuntu 18.04 LTS
# Last updated 20th June 2021

## Get Cloudflare IPv4 and IPv6 Addresses ##
ip4='https://www.cloudflare.com/ips-v4'
ip6='https://www.cloudflare.com/ips-v6'

## Temp file location ##
t_ip_4="$(/bin/mktemp /tmp/cloudflare.XXXXXXXX)"
t_ip_6="$(/bin/mktemp /tmp/cloudflare.XXXXXXXX)"

## Nginx config file for Cloudflare ##
conf_out="/etc/nginx/conf.d/cloudflare-real-ips.conf"

## Grab files ##
/usr/bin/wget -q -O $t_ip_4 $ip4
/usr/bin/wget -q -O $t_ip_6 $ip6

## Generate it ##
/usr/bin/awk '{ print "set_real_ip_from " $1 ";" }' $t_ip_4 > $conf_out
/usr/bin/awk '{ print "set_real_ip_from " $1 ";" }' $t_ip_6 >> $conf_out
echo 'real_ip_header CF-Connecting-IP;' >> $conf_out

## Delete temp files ##
[ -f "$t_ip_4" ] && /bin/rm -f $t_ip_4
[ -f "$t_ip_6" ] && /bin/rm -f $t_ip_6

## Reload Nginx ##
sudo service nginx reload
