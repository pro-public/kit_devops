for proto in 1 1_1 1_2 1_3; do openssl s_client -connect example.com:443 "-tls${proto}" 2>/dev/null < <(sleep 1; echo q) | grep Protocol | uniq; done
