#!/bin/bash

# Prompt for the target domain
read -p "Masukkan domain target (contoh: domain.com): " target_domain

# Create a folder with the name of the target domain
mkdir -p "$target_domain"

# Run the shodan command and process the results
shodan search hostname:"$target_domain" --fields ip_str,hostnames --separator " " | while read ip domain; do
    if [[ $domain =~ ^[a-zA-Z0-9.-]+$ ]]; then
        echo "$domain" >> "$target_domain/domain.txt"
    fi
    if [[ $ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        echo "$ip" >> "$target_domain/ip.txt"
    fi
done

echo "Proses selesai. Hasil tersimpan di folder: $target_domain"

