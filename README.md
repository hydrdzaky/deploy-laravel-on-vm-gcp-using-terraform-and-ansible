# Provisioning & Configuration Laravel Development VM on GCP

## Arsitektur
Service GCP yang digunakan:
- **VPC**
- **Subnet**
- **Firewall**
- **VM Instance**

Provisioning:
- **Terraform** → Membuat resource GCP
- **Ansible** → Mengkonfigurasi server Debian sesuai kebutuhan

---

## Prasyarat

Sebelum menjalankan script, pastikan:

1. **Service Account** GCP sudah dibuat dengan permission:
   - `Compute Engine Admin`
   - `Compute Network Admin`
2. **File credentials JSON** dari Service Account sudah diunduh dan dikonfigurasi di lokal:
   ```bash
   export GOOGLE_APPLICATION_CREDENTIALS="/path/to/credentials.json"
3. **SSH Key** sudah dibuat dan ditambahkan ke metadata project GCP, sehingga bisa digunakan untuk login ke VM:
    ```ssh-keygen -t rsa -b 4096 -C "your_email@example.com"``
4. **Terraform** sudah terinstal.
    Unduh di Terraform Downloads
5. **Ansible** sudah terinstal:
    ```pip install ansible```

## Langkah Eksekusi
1. **Provisioning Infrastruktur dengan Terraform**
    Masuk ke folder terraform:
    ```cd terraform/
    terraform init
    terraform plan
    terraform apply -auto-approve```

2. **Konfigurasi Server dengan Ansible**
    Masuk ke folder ansible dan update file inventory.ini:
    ```[webserver]<VM_PUBLIC_IP> ansible_user=<USERNAME> ansible_ssh_private_key_file=~/.ssh/id_rsa```
    Jalankan playbook :
    ```ansible-playbook -i inventory.ini playbook-main.yaml``

## Hasil Akhir
**Setelah seluruh proses selesai:**
- VM berjalan di GCP dengan konfigurasi:
    1. Apache 2.4.56
    2. PHP 8.2
    3. Node.js 20.13.1
    4. NPM 10.5.2
    5. Composer
    6. PHP Modules: php-fpm, curl, xml, mbstring, gd, imagick, imap, intl, mysqli, pgsql, zip
    7. Laravel 11
Akses Laravel melalui :
```http://34.128.91.21/```

## Struktur Project
```
.
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── ...
├── ansible/
│   ├── inventory.ini
│   ├── playbook-main.yaml
│   └── roles/
│       ├── apache/
│       ├── php/
│       ├── node/
│       ├── laravel/
│       └── ...
└── README.md```
