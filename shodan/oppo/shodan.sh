shodan search hostname:"opposhop.cn" --fields ip_str,hostnames --separator " " | while read ip domain; do
    if [[ $domain =~ ^[a-zA-Z0-9.-]+$ ]]; then
        echo "$domain" >> domain.txt
    fi
    if [[ $ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        echo "$ip" >> ip.txt
    fi
done

