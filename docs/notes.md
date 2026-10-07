# Catatan Belajar

## Masalah: ping client ke server gagal
- Gejala: ping ke 10.10.2.10 100% loss.
- Yang sudah benar: client bisa ping router, `ip_forward` = 1, router bisa ping server, tabel rute client dan server benar.
- Diagnosis: `tcpdump -ni any icmp` di router menangkap 0 paket, artinya paket tidak pernah sampai ke router.
- Dugaan: `internal: true` pada jaringan Docker membuang paket yang tujuannya di luar subnet.
- Perbaikan: hapus `internal: true`, lalu `docker compose down` dan `up -d`. Ping berhasil.

## Yang saya pelajari
- Router Linux = `ip_forward=1` + rute di tiap ujung (client dan server perlu tahu gateway).
- TTL turun 1 tiap melewati router (64 jadi 63).
- `traceroute` menunjukkan hop router.
- Debug dari yang terdekat: ping gateway, cek forwarding, lihat paket dengan tcpdump.
- Firewall default DROP lebih aman daripada memblokir satu per satu.

## Hasil sebelum firewall
- `ping 10.10.2.10`: berhasil, 0% loss
- `wget 10.10.2.10`: halaman Nginx muncul

## Hasil sesudah firewall
- `wget`: berhasil
- `ping`: 100% loss
- Counter iptables: policy DROP menghitung paket ping yang dibuang