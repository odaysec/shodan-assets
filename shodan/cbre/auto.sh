#!/bin/bash

# Cek apakah file target diberikan sebagai argumen
if [ "$#" -ne 1 ]; then
    echo "Usage: bash run.sh target.txt"
    exit 1
fi

# File target yang berisi daftar domain
target_file="$1"

# Cek apakah file target ada
if [ ! -f "$target_file" ]; then
    echo "File $target_file tidak ditemukan!"
    exit 1
fi

# Membaca domain satu per satu dari file target
while read -r target_domain; do
    # Lewati baris kosong
    if [ -z "$target_domain" ]; then
        continue
    fi

    echo "Memproses domain: $target_domain"

    # Membuat folder untuk domain
    mkdir -p "$target_domain"

    # Menjalankan perintah Shodan dan menyimpan hasilnya
    shodan search hostname:"$target_domain" --fields ip_str,hostnames --separator " " | while read ip domain; do
        if [[ $domain =~ ^[a-zA-Z0-9.-]+$ ]]; then
            echo "$domain" >> "$target_domain/domain.txt"
        fi
        if [[ $ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
            echo "$ip" >> "$target_domain/ip.txt"
        fi
    done

    echo "Hasil untuk $target_domain disimpan di folder: $target_domain"

done < "$target_file"

echo "Proses selesai untuk semua domain di $target_file."

