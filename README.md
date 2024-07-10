# neoBankClone
![Header](https://imgtr.ee/images/2024/07/10/1e4bc234e43bef51f3d1bada850cc77c.png)

## Deskripsi
**neoBankClone** adalah aplikasi cloning UI dari aplikasi Neo Bank Commerce dengan beberapa fitur serupa. Aplikasi ini dirancang untuk memberikan pengalaman perbankan yang mudah dan aman bagi pengguna, mencakup fitur-fitur seperti pengelolaan produk, pembayaran, dan berbagai opsi rollover deposito.

## Fitur Utama
### 1. Landing Page (Wealth)
Halaman awal yang menampilkan daftar produk dari Neo Commerce dengan dua kategori: Fleksible dan Fixed. Kategori dapat dipilih melalui tombol opsi di atas.

#### Requirement:
- Page Header
- Pagination page
- Segmented Control/Navigation control, dengan garis kuning yang dapat bergerak
- Daftar produk menggunakan UITableView
- Mengonsumsi mock API

### 2. Product Detail Page
Halaman detail produk yang memungkinkan pengguna memasukkan nominal dan menghitung estimasi bunga berdasarkan suku bunga, durasi, dan pokok. Terdapat opsi pemilihan amount, rollover menggunakan bottom sheet dialog, dan link TNC yang membuka webview dalam aplikasi. Tombol "Buka Sekarang" akan aktif setelah nominal valid dan TnC disetujui.

#### Requirement:
- Amount TextField dengan format numerik
- Pilihan Amount yang terhubung ke textfield
- Kalkulasi estimasi bunga setiap kali pengguna selesai memasukkan nominal
- Menampilkan pilihan menggunakan Bottom Sheet Dialog
- Link TNC -> membuka in-app webview.

### 3. Halaman Pembayaran
Halaman ini menampilkan countdown untuk batas waktu pembayaran, nominal yang harus dibayar berdasarkan halaman sebelumnya, dan pilihan metode pembayaran lainnya (Virtual Account, Credit Card, dan EMoney) yang dapat di-expand dan collapse untuk menampilkan pilihan channel.

#### Requirement:
- Menggunakan gambar lokal untuk background dan ikon
- Countdown yang berfungsi
- View yang bisa collapse dan expand

## Tech Stack
- XCode
- Swift Programming Language

## Clean Code dan Arsitektural Pattern VIPER
Proyek ini mengikuti prinsip clean code dan menggunakan arsitektural pattern VIPER. 

### Apa itu VIPER?
VIPER adalah singkatan dari:
- **View**: Bertanggung jawab untuk menampilkan data dan merespon interaksi pengguna.
- **Interactor**: Berisi logika bisnis dan pemrosesan data aplikasi.
- **Presenter**: Bertindak sebagai mediator antara View dan Interactor. Menerima input dari View dan mengirimkan data ke Interactor, lalu mengambil data dari Interactor dan mengirimkannya ke View.
- **Entity**: Model data yang digunakan oleh Interactor.
- **Router**: Bertanggung jawab untuk navigasi aplikasi.

### Mengapa Menggunakan VIPER?
1. **Pemisahan Tugas**: Memisahkan tugas masing-masing komponen membuat kode lebih modular dan mudah di-maintain.
2. **Skalabilitas**: Memungkinkan pengembangan aplikasi yang lebih besar dan kompleks dengan struktur yang jelas.
3. **Testabilitas**: Memudahkan penulisan unit test karena setiap komponen memiliki tanggung jawab yang terpisah.

## Instalasi
1. Clone repository ini:
    ```bash
    git clone https://github.com/username/neoBankClone.git
    ```
2. Buka proyek di Xcode:
    ```bash
    cd neoBankClone
    open neoBankClone.xcodeproj
    ```

## Cara Penggunaan
1. Compile dan jalankan proyek di simulator atau perangkat nyata.
2. Navigasi melalui aplikasi untuk mengeksplorasi fitur-fitur yang tersedia.
3. no using any 3rd party Libraries, only using iOS native Framework to reduce compexity
4. URLSession for network calling

## Kontribusi
Kami menyambut kontribusi dari siapa saja. Silakan buka pull request atau ajukan issue untuk diskusi lebih lanjut.

## Lisensi
Proyek ini dilisensikan di bawah lisensi MIT - lihat file [LICENSE](LICENSE) untuk detail lebih lanjut.

## Kontak
Jika kamu memiliki pertanyaan atau saran, silakan hubungi saya melalui:
- [LinkedIn](https://www.linkedin.com/in/anangnugraha/)
- [Medium](https://anangnugraha.medium.com/)
- Email: anangnugraha8@gmail.com

