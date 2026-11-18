# Playbook Lengkap Ekosistem Agent Skills

Panduan praktis mengoptimalkan seluruh plugin yang terinstal melalui repo ini (`autopilot-workflows`, `mattpocock-skills`, `superpowers`, `antislop`, `vercel-agent-skills`, `anthropics-skills`) baik untuk membangun proyek baru dari 0 hingga selesai maupun menganalisa serta merombak proyek yang sudah berjalan.

---

## 1. Peta Peran Plugin & Aturan Anti-Konflik

* **`autopilot-workflows`** *(termasuk global `rules/AGENTS.md`)*: Memetakan maksud user ke skill yang tepat secara otomatis dan menyediakan perintah 1x jalan (`/autopilot-build`, `/autopilot-ui-fix`).
* **`mattpocock-skills`**: Alur kerja interaktif utama (`setup-matt-pocock-skills` → `grill-with-docs` → `to-spec` → `to-tickets` → `implement` / `implement-spec` → `code-review` → `retro`).
* **`superpowers`**: Disiplin eksekusi engineering (`using-git-worktrees`, `verification-before-completion`, `finishing-a-development-branch`). *Tips: jangan campurkan alur planning `mattpocock` dan `superpowers` sekaligus di satu fitur—pakai `mattpocock` sebagai jalur utama, dan ambil skill spesifik `superpowers` saat perlu.*
* **`antislop` + `frontend-design` + `vercel-agent-skills` + `webapp-testing`**: Lapisan kualitas frontend yang bekerja bersamaan (*composable*).

---

## 2. Skenario A: Proyek Baru dari 0 → Finish (Greenfield)

### Opsi 1 — 1x Eksekusi (Autopilot)
1. Buat folder proyek baru, jalankan `git init`, dan buka sebagai active workspace.
2. Jalankan:
   ```text
   /autopilot-build <jelaskan produk, fitur utama, stack yang diinginkan, dan preferensi gaya visual>
   ```
   *(Opsional gabungkan dengan `/goal` bila proyek besar.)*

### Opsi 2 — Terkendali & Interaktif (Untuk Sistem Kritis)
1. **Setup**: `/setup-matt-pocock-skills` (pilih Local markdown `.scratch/` atau GitHub Issues, dan `AGENTS.md`).
2. **Kunci Domain & Arsitektur** *(jangan `/clear` dulu)*:
   * `/wayfinder` (jika ide masih sangat luas & kabur) atau langsung `/grill-with-docs` (menghasilkan `GLOSSARY.md` dan `docs/adr/`).
3. **Kunci Arah UI**:
   * Minta agen membuat `DESIGN.md` dengan `frontend-design` + `antislop` mode `during`.
   * Uji 3 varian layout di browser menggunakan `/prototype` (`?variant=A|B|C`).
4. **Spec & Tiket**: `/to-spec` → `/to-tickets` (vertical tracer-bullet slices + blocking edges).
5. **Implementasi** *(lakukan `/clear` terlebih dahulu)*:
   * `/implement <tiket>` satu per satu (disertai `/clear` antar tiket) atau `/implement-spec` (paralel di worktree).
6. **QA, Review & Retro**:
   * Uji UI nyata dengan `webapp-testing` (Playwright) dan `web-design-guidelines`.
   * Jalankan `/code-review` (Standards + Spec) dan `verification-before-completion`.
   * Tutup dengan `/pr` dan `/retro` sebelum `/clear`.

---

## 3. Skenario B: Proyek yang Sudah Berjalan (Existing Codebase)

### B1. UI Terlanjur Terasa "AI Slop"
* **Instan (1x perintah):**
  ```text
  /autopilot-ui-fix <opsional: sebutkan gaya visual atau referensi desain yang diinginkan>
  ```
* **Bertahap (Audit → Approve → Rombak):**
  1. Buat commit Git baseline terlebih dahulu.
  2. Jalankan audit read-only dengan `antislop` mode **After** + `web-design-guidelines` + `vercel-react-best-practices`.
  3. Buat `DESIGN.md` dengan `frontend-design`, lalu terapkan dengan `antislop` mode **During** + `vercel-composition-patterns`.
  4. Verifikasi tampilan desktop & mobile dengan `webapp-testing` (Playwright).

### B2. Analisa & Refactor Arsitektur Kode
```text
/improve-codebase-architecture Fokus analisa pada modul [nama folder/modul] untuk mencari shallow module dan perbaikan seam testability.
```

### B3. Debugging Bug Membandel / Regresi
```text
/diagnosing-bugs [jelaskan gejala bug dan cara reproduksinya]
```
Agen wajib membangun *tight feedback loop* (perintah/test yang konsisten gagal merah) sebelum menyentuh kode perbaikan.

### B4. Tambah Fitur Baru ke Proyek Berjalan
1. Commit perubahan sebelumnya agar diff bersih.
2. Jalankan `/grill-with-docs <ide fitur baru>` (otomatis membaca `GLOSSARY.md` & `docs/adr/`).
3. Fitur kecil → langsung `/implement`. Fitur besar → `/to-spec` → `/to-tickets` → `/clear` → `/implement-spec`.

### B5. Memilah Backlog / Bug Report Masuk
```text
/triage
```

---

## 4. Template `AGENTS.md` untuk Setiap Proyek Baru

Taruh `AGENTS.md` ringkas di root proyek agar agen langsung paham orientasi codebase di setiap sesi baru:

```markdown
# Project Instructions

## Read First
- Domain terms: `GLOSSARY.md`
- Architecture decisions: `docs/adr/`
- UI direction & tokens: `DESIGN.md`
- Specs & tickets: `.scratch/` (see `docs/agents/issue-tracker.md`)

## Verification Commands
- Backend tests: `<command test backend>`
- Frontend checks: `<command typecheck && lint && test && build>`
```
