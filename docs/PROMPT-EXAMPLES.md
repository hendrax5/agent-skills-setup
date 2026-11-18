# Sample Variasi Prompt yang Baik & Benar

Kumpulan contoh prompt siap pakai yang dirancang sesuai mekanisme skill di ekosistem ini (`autopilot-workflows`, `mattpocock-skills`, `superpowers`, `antislop`, `vercel-agent-skills`, dan `anthropics-skills`).

---

## Prinsip Prompt yang Efektif

| Jangan Tulis Seperti Ini (Samar → Hasil *Slop*) | Tulis Seperti Ini (Terarah & Spesifik) |
| :--- | :--- |
| *"Buatkan dashboard monitoring yang bagus dan modern."* | *"Gunakan `frontend-design` dan `antislop` mode `during` untuk membuat `DESIGN.md` bergaya NOC telemetry gelap berdensitas tinggi, font monospace tabular untuk IP/ASN, tanpa gradien dekoratif."* |
| *"Perbaiki bug loginnya."* | *"`/diagnosing-bugs` Login RADIUS masih fallback ke akun lokal saat server mengembalikan `Access-Reject`. Buat reproduksi test gagal dulu sesuai ADR-0004 sebelum memperbaiki kode."* |
| *"Rapikan kode frontend saya."* | *"Audit `frontend/src/` menggunakan `vercel-react-best-practices`, `vercel-composition-patterns`, dan `web-design-guidelines`, lalu perbaiki temuan prioritas tinggi tanpa mengubah kontrak API."* |

---

## 1. Proyek Baru dari 0 → Finish (Autopilot 1x Eksekusi)

Gunakan saat gambaran aplikasi sudah cukup jelas dan Anda ingin agen mengeksekusi dari arsitektur hingga verifikasi akhir tanpa bertanya berulang kali.

### Variasi A — Web App Teknis / Dashboard (NOC, Monitoring, DevOps)
```text
/autopilot-build Buat web app monitoring layanan MikroTik & BGP peer real-time.
Fitur inti:
1. Inventory router & credential profile terenkripsi
2. Polling BGP status + WebSocket live updates
3. Config backup otomatis + visual diff
Stack: Python FastAPI + PostgreSQL/Redis + Next.js TypeScript.
Gaya UI: high-density dark operational terminal (terinspirasi Grafana/NetBox), font monospace tabular untuk IP/ASN, fokus pada kecepatan baca status DOWN/FLAP.
```

### Variasi B — Aplikasi Bisnis / SaaS (CRM, Inventory, Finance)
```text
/autopilot-build Buat sistem manajemen invoice dan langganan untuk agensi kecil.
Fitur inti: manajemen klien, pembuatan invoice PDF, status pembayaran, dan reminder jatuh tempo.
Stack: Next.js App Router + TypeScript + PostgreSQL/Prisma.
Gaya UI: editorial terang (warm paper background, aksen ink gelap & satu warna aksen terukur), tabel bersih tanpa kartu berlebih.
```

### Variasi C — Menjalankan Tugas Sangat Besar dengan Persistensi Ekstra
Tambahkan `/goal` di awal agar agen tidak berhenti di tengah sebelum seluruh tiket dan verifikasi selesai:
```text
/goal /autopilot-build Bangun platform internal portal dokumentasi API dan playground interaktif dengan autentikasi SSO, pencarian full-text, dan role Editor vs Viewer.
```

---

## 2. Proyek Baru dari 0 (Mode Interaktif / Terkendali)

Gunakan saat masih banyak keputusan arsitektur/bisnis yang ingin Anda kunci langsung lewat diskusi sebelum coding dimulai.

### A. Proyek Sangat Besar & Masih Berkabut (`/wayfinder`)
```text
/setup-matt-pocock-skills
```
*(Setelah setup tracker selesai, jangan `/clear` dulu:)*
```text
/wayfinder Saya ingin membangun sistem multi-tenant billing & metering untuk layanan cloud lokal, tetapi skema pricing, proration, dan mekanisme retry invoice masih perlu dipetakan keputusannya sebelum masuk spec.
```

### B. Proyek Terarah (`/grill-with-docs` → `/to-spec` → `/to-tickets`)
```text
/grill-with-docs Saya ingin membangun web app kasir & stok multi-cabang dengan sinkronisasi offline-first. Wawancarai saya untuk mengunci domain glossary dan ADR-nya.
```
*(Setelah wawancara selesai, tetap di sesi yang sama:)*
```text
/to-spec
```
```text
/to-tickets
```
*(Setelah file tiket terbit, lakukan **`/clear`**, lalu eksekusi:)*
* Bertahap per tiket:
  ```text
  /implement .scratch/nama-fitur/issues/01-bootstrap.md
  ```
* Atau paralel seluruh spec:
  ```text
  /implement-spec .scratch/nama-fitur/spec.md
  ```

---

## 3. Desain UI & Menghilangkan "AI Slop"

### A. Rombak Total UI Existing dalam 1 Perintah (`/autopilot-ui-fix`)
* **Gaya NOC / Telemetry (Gelap, Padat, Teknis):**
  ```text
  /autopilot-ui-fix Rombak seluruh UI frontend agar bebas AI slop dengan gaya high-density NOC telemetry (latar gelap netral, kontras tinggi, font tabular monospace untuk angka/IP/ASN, tabel padat, dan hilangkan re-mount flicker saat live update).
  ```
* **Gaya Enterprise Clean / Editorial (Terang, Profesional):**
  ```text
  /autopilot-ui-fix Rombak tampilan dashboard menjadi gaya enterprise Swiss-grid terang yang bersih, hirarki tipografi tegas, navigasi ringkas, dan responsif penuh di mobile.
  ```

### B. Audit UI Read-Only Dulu (`antislop` Mode `AFTER`)
Cocok jika Anda ingin melihat daftar masalahnya dulu sebelum mengizinkan agen mengubah satu baris kode pun:
```text
Gunakan antislop mode AFTER (antislop-ui, antislop-human, antislop-layoutmobile, antislop-copywriting), web-design-guidelines, dan vercel-react-best-practices untuk mengaudit seluruh halaman di frontend/src/.
Jangan ubah kode dulu—tulis daftar temuan bernomor beserta prioritasnya agar saya bisa memilih mana yang perlu diperbaiki.
```

### C. Menetapkan Arah Visual Sebelum Coding (`DESIGN.md` + `frontend-design`)
```text
Gunakan skill frontend-design dan antislop mode DURING untuk membuat DESIGN.md di root proyek.
Produk ini dipakai oleh network engineer di ruang NOC 24 jam. Hindari template dark slate generik atau gradien ungu/biru; tentukan palet warna fungsional (status healthy/warning/critical), skala tipografi, aturan tabel padat, dan spacing yang konsisten.
```

### D. Eksplorasi 3 Varian Layout Sebelum Memilih (`/prototype`)
```text
/prototype Buat 3 variasi layout yang strukturnya benar-benar berbeda untuk halaman /dashboard (?variant=A|B|C dengan floating switcher bar) sambil mempertahankan data fetch asli, lalu saya akan pilih varian terbaiknya.
```

---

## 4. Optimasi React/Next.js & Pengujian Browser Nyata

### A. Audit Performa & Pola Komposisi React/Next.js
```text
Audit komponen di frontend/src/ menggunakan vercel-react-best-practices dan vercel-composition-patterns:
- Hilangkan waterfall data fetching
- Kurangi client bundle & re-render yang tidak perlu
- Ganti komponen dengan prop boolean berlebihan menjadi compound components yang bersih
Jalankan typecheck dan unit test setelah refactor.
```

### B. Audit Aksesibilitas & UX (`web-design-guidelines` + `antislop-human`)
```text
Periksa semua form, modal/drawer, dan tabel di frontend/src/ terhadap web-design-guidelines dan antislop-human: cek kontras warna, label form, navigasi keyboard, focus-visible, serta layout mobile 375px.
```

### C. Pengujian UI End-to-End di Browser (`webapp-testing`)
```text
Gunakan webapp-testing (Playwright) untuk menjalankan test pada server lokal:
1. Login menggunakan akun test/break-glass
2. Verifikasi halaman /dashboard, /devices, /backups, dan /settings
3. Pastikan tidak ada console error atau horizontal overflow di viewport desktop (1440px) dan mobile (375px)
4. Simpan screenshot hasil verifikasi.
```

---

## 5. Analisa & Perbaikan Proyek yang Sudah Berjalan (Existing Codebase)

### A. Analisa Arsitektur & Mencari Kandidat Refactoring (`/improve-codebase-architecture`)
```text
/improve-codebase-architecture Fokus memindai area backend/src/collectors dan backend/src/services untuk menemukan shallow modules, duplikasi logic antar vendor, dan celah seam yang sulit dites.
```

### B. Debugging Bug Sulit / Regresi (`/diagnosing-bugs`)
```text
/diagnosing-bugs WebSocket live update berhenti menerima event setelah router reconnect, dan tabel BGP ikut berkedip setiap kali ada pesan masuk. Bangun test/repro gagal terlebih dahulu sebelum mengubah kode perbaikan.
```

### C. Menambah Fitur Baru ke Proyek yang Sudah Ada
1. Pastikan perubahan lama sudah di-commit di Git, lalu jalankan:
   ```text
   /grill-with-docs Saya ingin menambahkan fitur export laporan bulanan BGP Flap dan Config Drift ke format PDF dan Excel (XLSX), lengkap dengan tombol download di halaman /audit.
   ```
2. Setelah spec/tiket siap dan di-implement, manfaatkan skill dokumen (`pdf` & `xlsx`) dari `anthropics-skills` saat membangun generator ekspornya.

### D. Review Kode Sebelum Merge (`/code-review`) & Evaluasi (`/retro`)
```text
/code-review Bandingkan branch saat ini terhadap main menggunakan .scratch/nama-fitur/spec.md sebagai acuan Spec.
```
*(Setelah review selesai dan sebelum `/clear` sesi:)*
```text
/retro Evaluasi sesi implementasi barusan—apakah ada lint rule, check otomatis, atau pointer di AGENTS.md yang perlu ditambahkan agar kesalahan serupa tidak terulang?
```

### E. Memilah Issue / Bug Report Masuk (`/triage`)
```text
/triage Evaluasi laporan bug baru di tracker, cek reproduksinya di codebase, dan beri label ready-for-agent jika sudah lengkap atau needs-info jika masih kurang data.
```

---

## 6. Utilitas Khusus (Setup Manual, Riset, Dokumen, MCP, Skill Baru)

* **Membuat skrip interaktif untuk langkah manual manusia (`/wizard`):**
  ```text
  /wizard Buatkan skrip setup interaktif untuk mengisi .env produksi (POSTGRES_PASSWORD, JWT_SECRET, ENCRYPTION_MASTER_KEY, dan konfigurasi RADIUS secret) dengan validasi input.
  ```
* **Riset library/protokol di latar belakang (`/research`):**
  ```text
  /research Investigasi perbedaan struktur SNMP BGP4-MIB standar vs MIB vendor Juniper dan Huawei VRP untuk penghitungan prefix IPv4/IPv6 per VRF, simpan hasilnya ke docs/research/bgp-mib-comparison.md.
  ```
* **Membuat laporan/presentasi/spreadsheet (`docx`, `pptx`, `xlsx`, `pdf`):**
  ```text
  Gunakan skill pptx untuk membuat deck presentasi arsitektur NMS BGP (10 slide: masalah, arsitektur hybrid, keamanan read-only + redaction, dan roadmap) berdasarkan spec.md dan docs/adr/.
  ```
* **Membangun MCP Server baru (`mcp-builder`):**
  ```text
  Gunakan skill mcp-builder untuk membuat MCP server berbasis Python FastMCP yang mengekspos status BGP peer dan riwayat Config Drift dalam mode read-only.
  ```
* **Membuat atau menyempurnakan skill kustom baru (`skill-creator`):**
  ```text
  Gunakan skill skill-creator untuk merancang skill baru khusus audit konfigurasi router MikroTik/Juniper lengkap dengan test kasus pemicu deskripsinya.
  ```

---

## Ringkasan Kesalahan Umum yang Perlu Dihindari

1. **Jangan `/clear` di tengah fase perencanaan:** Pertahankan 1 sesi utuh dari `/grill-with-docs` → `/to-spec` → `/to-tickets`, lalu **wajib `/clear`** sebelum mulai `/implement`.
2. **Jangan minta "buat UI bagus" tanpa arah:** Selalu sertakan referensi gaya atau minta dibuatkan `DESIGN.md` lebih dulu (`frontend-design`).
3. **Jangan lupa commit baseline sebelum `/autopilot-ui-fix` atau `/code-review`:** Review dua sumbu butuh titik pembanding Git yang bersih.
4. **Jangan gabung dua *process driver* sekaligus:** Hindari memicu alur planning `superpowers` (`writing-plans` + `executing-plans`) bersamaan dengan `mattpocock` (`to-tickets` + `implement-spec`) pada tugas yang sama.
