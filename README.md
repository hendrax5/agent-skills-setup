# Agent Skills Setup & Autopilot Workflows

Setup lengkap ekosistem AI coding agent plugins untuk **Antigravity** (Windows / PowerShell), dilengkapi plugin orkestrator kustom **`autopilot-workflows`** agar agen langsung memahami alur kerja mulai dari membuat proyek dari 0 sampai selesai maupun mengaudit/merombak UI proyek yang sudah berjalan.

## Isi Repositori

- `autopilot-workflows/`: Plugin custom Antigravity berisi:
  - `rules/AGENTS.md`: Workflow router otomatis agar agen langsung memilih skill & dokumen proyek (`GLOSSARY.md`, `DESIGN.md`, `docs/adr/`, `.scratch/`) dengan tepat.
  - `/autopilot-build`: Orkestrator 1 perintah untuk proyek dari `0 → finish` (arsitektur, domain glossary/ADR, `DESIGN.md`, spec, tiket *vertical-slice*, implementasi TDD, Playwright/browser QA, & *dual-axis code review*).
  - `/autopilot-ui-fix`: Orkestrator 1 perintah untuk mengaudit dan merombak total frontend yang terasa *AI slop*.
- `install-all.ps1`: Skrip bootstrap otomatis untuk memasang seluruh plugin di mesin baru.
- `docs/PLAYBOOK.md`: Panduan lengkap optimasi semua plugin, auto-orientation, alur kerja 0 → finish, proyek berjalan, & cheat-sheet prompt.
- `docs/playbook-optimasi-skills.md`: Playbook optimasi skill (diagram alur, fase 0–5, dan cheat-sheet prompt siap pakai).

---

## Quick Start (Install di PC / Laptop Baru)

1. Pastikan `git` sudah terpasang, lalu clone repo ini:
   ```powershell
   git clone https://github.com/hendrax5/agent-skills-setup.git
   cd agent-skills-setup
   ```
2. Jalankan skrip instalasi (opsional tambahkan `-AntislopMode during` agar `antislop` tidak selalu bertanya mode di sesi biasa):
   ```powershell
   .\install-all.ps1 -AntislopMode during
   ```
3. Buka **Antigravity IDE** dan instal plugin **Superpowers** (`obra/superpowers`) dari **Agent Marketplace**.
4. Mulai sesi baru — seluruh 6 plugin siap dipakai otomatis.

---

## Ringkasan Plugin yang Terpasang

| Plugin | Asal | Fungsi Utama |
| :--- | :--- | :--- |
| **`autopilot-workflows`** | Repo ini | Router otomatis (`rules/AGENTS.md`) + `/autopilot-build` & `/autopilot-ui-fix` |
| **`mattpocock-skills`** | `mattpocock/skills` | Workflow *idea → ship*, domain modeling, vertical-slice tickets, TDD, retro |
| **`superpowers`** | `obra/superpowers` *(Marketplace)* | Disiplin engineering (brainstorming, worktree, verification gates) |
| **`antislop`** | `miqdadbadjuber/anti-slop` | Filter penghapus *AI slop* (UI, copy, aksesibilitas, mobile, komentar kode) |
| **`vercel-agent-skills`** | `vercel-labs/agent-skills` | Performa React/Next.js, *composition patterns*, Web Interface Guidelines |
| **`anthropics-skills`** | `anthropics/skills` | `frontend-design`, Playwright `webapp-testing`, `docx`/`pdf`/`pptx`/`xlsx`, `mcp-builder` |

---

## Contoh Perintah Cepat

* **Bangun proyek dari 0 dalam 1 eksekusi:**
  ```text
  /autopilot-build Buat web app [jelaskan tujuan, fitur inti, dan preferensi stack/gaya].
  ```
* **Rombak UI existing yang terasa "slop" dalam 1 eksekusi:**
  ```text
  /autopilot-ui-fix Audit dan rombak UI di proyek ini agar tajam, responsif, dan bebas AI slop.
  ```
* **Mode interaktif (mengunci keputusan satu per satu):**
  ```text
  /setup-matt-pocock-skills
  /grill-with-docs <ide fitur atau proyek>
  ```

Lihat panduan selengkapnya di [`docs/PLAYBOOK.md`](docs/PLAYBOOK.md) atau [`docs/playbook-optimasi-skills.md`](docs/playbook-optimasi-skills.md).
