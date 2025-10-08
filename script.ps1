# === KONFIGURASI ===
$VaultPath = "$HOME\Documents\Obsidian\UT Semester 5"

# === DAFTAR FOLDER DASAR ===
$baseFolders = @(
  "01_Inbox",
  "02_Literature",
  "03_Zettel",
  "04_Courses",
  "05_Projects",
  "06_OKR",
  "07_Reviews",
  "99_Templates"
)

# === MATA KULIAH ===
$courses = @(
  "Teori dan Masalah Penerjemahan 91",
  "Academic Speaking 11",
  "Perkembangan Peserta Didik 224",
  "Filsafat Ilmu 30",
  "Profesi Keguruan 319",
  "English for Business 2",
  "English Morphology and Syntax 2",
  "Introduction to Linguistics 3"
)

# === BUAT VAULT DAN FOLDER DASAR ===
New-Item -ItemType Directory -Force -Path $VaultPath | Out-Null
$baseFolders | ForEach-Object { New-Item -ItemType Directory -Force -Path (Join-Path $VaultPath $_) | Out-Null }

# === BUAT FOLDER PER MATA KULIAH ===
$courses | ForEach-Object {
  $cPath = Join-Path $VaultPath "04_Courses\$_"
  New-Item -ItemType Directory -Force -Path $cPath | Out-Null
  # Subfolder berguna
  New-Item -ItemType Directory -Force -Path (Join-Path $cPath "Meetings") | Out-Null
  New-Item -ItemType Directory -Force -Path (Join-Path $cPath "Assignments") | Out-Null
  New-Item -ItemType Directory -Force -Path (Join-Path $cPath "Readings") | Out-Null
}

# === TEMPLATE DASAR ===
$tmplPath = Join-Path $VaultPath "99_Templates"
@"
---
type: meeting
course: <% tp.file.folder() %>
date: <% tp.date.now("YYYY-MM-DD") %>
---
# Topik
- 

## 3 Insight
- 

## 3 Pertanyaan
- 

## Rencana latihan/reading
- 
"@ | Set-Content -Encoding UTF8 (Join-Path $tmplPath "template_meeting.md")

@"
---
type: literature
source: 
date: <% tp.date.now("YYYY-MM-DD") %>
---
## Ringkasan (5-7 kalimat)

## Kutipan kunci
- 

## Tautan ke Zettel
- [[ ]]

"@ | Set-Content -Encoding UTF8 (Join-Path $tmplPath "template_literature.md")

@"
---
type: zettel
created: <% tp.date.now("YYYY-MM-DD") %>
---
# Ide utama

## Kenapa penting

## Terkait
- [[ ]]

## Pertanyaan lanjutan
- 
"@ | Set-Content -Encoding UTF8 (Join-Path $tmplPath "template_zettel.md")

@"
---
type: okr
period: Q<% tp.date.now("Q-YYYY") %>
---
# Objective
- 

## Key Results
- 

## Inisiatif
- 
"@ | Set-Content -Encoding UTF8 (Join-Path $tmplPath "template_okr.md")

Write-Host "Selesai! Buka folder ini sebagai Vault di Obsidian: $VaultPath"
