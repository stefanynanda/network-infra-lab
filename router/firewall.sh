#!/bin/sh
# Bersihkan aturan lama
iptables -F FORWARD

# Default: blokir semua lalu lintas yang melewati router
iptables -P FORWARD DROP

# Izinkan balasan dari koneksi yang sudah berjalan
iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Izinkan client (subnet A) mengakses web server di port 80 saja
iptables -A FORWARD -s 10.10.1.0/24 -d 10.10.2.10 -p tcp --dport 80 -j ACCEPT