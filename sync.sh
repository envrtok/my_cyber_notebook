#!/usr/bin/env bash
# ------------------------------------------------------------------
#  my_cyber_notebook  ->  GitHub senkronizasyonu
#
#  İlk çalıştırma : bash sync.sh      (git + GitHub kurulumu, depoyu oluşturur)
#  Sonraki her çalıştırma: README dizinini günceller, değişiklikleri commit'ler
#  ve GitHub'a gönderir. Değişiklik yoksa hiçbir şey yapmaz.
# ------------------------------------------------------------------
set -euo pipefail

REPO_NAME="${REPO_NAME:-my_cyber_notebook}"   # GitHub'daki depo adı
VISIBILITY="${VISIBILITY:-public}"            # public | private
BRANCH="main"

NOTEBOOK_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
SCRIPT_PATH="$NOTEBOOK_DIR/sync.sh"
LOG_FILE="$HOME/.cache/notebook-sync.log"
cd "$NOTEBOOK_DIR"

interactive() { [ -t 0 ] && [ -t 1 ]; }
# Renkler sadece terminalde; cron log'una düz metin + zaman damgası yazılır
if interactive; then C_OK=$'\033[1;36m'; C_ERR=$'\033[1;31m'; C_END=$'\033[0m'; else C_OK=""; C_ERR=""; C_END=""; fi
ts()  { date '+%Y-%m-%d %H:%M:%S'; }
say() { printf '%s[sync %s]%s %s\n' "$C_OK" "$(ts)" "$C_END" "$*"; }
die() { printf '%s[sync %s] HATA:%s %s\n' "$C_ERR" "$(ts)" "$C_END" "$*" >&2; exit 1; }

# Aynı anda iki kopya çalışmasın (cron + elle çalıştırma çakışmasın).
# Yol sabit: cron'da XDG_RUNTIME_DIR tanımlı olmadığından eskiden cron ile
# terminal farklı kilit dosyası kullanıyordu ve kilit birbirini görmüyordu.
exec 9>"/tmp/notebook-sync-$(id -u).lock"
flock -n 9 || { say "Zaten çalışan bir senkron var, çıkılıyor."; exit 0; }

# ------------------------------------------------------------------
# 1) README.md içindeki "Not Dizini" bölümünü yeniden üret
# ------------------------------------------------------------------
pretty() {  # "03_RECON_&_OSINT" -> "03 · RECON & OSINT"
  local s="${1//_/ }"
  printf '%s' "$s" | sed -E 's/^([0-9]+) /\1 · /'
}

generate_index() {
  local total top mid prev_top="" prev_mid="__none__" f rest name count
  total=$(find . -type f -name '*.md' -not -path './.git/*' -not -name 'README.md' | wc -l)
  echo ""
  echo "![Notlar](https://img.shields.io/badge/notlar-${total}-0f766e?style=flat-square)"
  echo ""
  # "klasör<TAB>dosya" olarak sıralanır: bir klasördeki notlar alt klasörlerinden
  # önce gelir, böylece aynı başlık dizinde iki kez görünmez.
  find . -type f -name '*.md' -not -path './.git/*' -not -name 'README.md' -printf '%h\t%f\n' \
    | LC_ALL=C sort \
    | while IFS=$'\t' read -r dir base; do
        [ "$dir" = "." ] && continue             # kök dizindeki .md dosyalarını atla
        f="${dir#./}/$base"
        top="${f%%/*}"
        rest="${f#*/}"
        if [[ "$rest" == */* ]]; then mid="${rest%/*}"; else mid=""; fi
        name="$(basename "$f" .md)"

        if [ "$top" != "$prev_top" ]; then
          count=$(find "./$top" -type f -name '*.md' | wc -l)
          echo ""
          echo "### 📂 $(pretty "$top") <sub>($count)</sub>"
          echo ""
          prev_top="$top"; prev_mid="__none__"
        fi
        if [ "$mid" != "$prev_mid" ]; then
          [ -n "$mid" ] && echo "- **${mid//\// › }**"
          prev_mid="$mid"
        fi
        if [ -n "$mid" ]; then
          echo "  - [$name](<$f>)"
        else
          echo "- [$name](<$f>)"
        fi
      done
  echo ""
}

update_readme() {
  [ -f README.md ] || return 0
  grep -q '<!-- INDEX:START -->' README.md || return 0
  local tmp; tmp="$(mktemp)"
  generate_index > "$tmp.idx"
  awk -v idx="$tmp.idx" '
    /<!-- INDEX:START -->/ { print; while ((getline line < idx) > 0) print line; skip=1; next }
    /<!-- INDEX:END -->/   { skip=0 }
    !skip { print }
  ' README.md > "$tmp"
  if ! cmp -s "$tmp" README.md; then cat "$tmp" > README.md; fi
  rm -f "$tmp" "$tmp.idx"
}

# ------------------------------------------------------------------
# 2) İlk kurulum (sadece gerekirse)
# ------------------------------------------------------------------
command -v git >/dev/null || die "git kurulu değil:  sudo apt install git"

if [ ! -d .git ]; then
  say "Git deposu başlatılıyor..."
  git init -q
  git symbolic-ref HEAD "refs/heads/$BRANCH"
fi

# Commit'lerin GitHub katkı grafiğinde SANA yazılması için kimlik şart
if [ -z "$(git config user.email || true)" ]; then
  if interactive; then
    read -rp "GitHub'da kayıtlı e-posta adresin: " GIT_EMAIL
    read -rp "Commit'lerde görünecek adın: " GIT_NAME
    git config user.email "$GIT_EMAIL"
    git config user.name "$GIT_NAME"
  else
    die "git kullanıcı bilgisi yok. Bir kez elle çalıştır: bash $SCRIPT_PATH"
  fi
fi

# ------------------------------------------------------------------
# 3) Commit
# ------------------------------------------------------------------
update_readme
git add -A
if ! git diff --cached --quiet; then
  changed=$(git diff --cached --name-only | wc -l)
  git commit -q -m "📝 Notlar güncellendi ($changed dosya) — $(date '+%Y-%m-%d %H:%M')"
  say "$changed dosya commit'lendi."
else
  say "Yeni değişiklik yok."
fi

# ------------------------------------------------------------------
# 4) GitHub'a gönder
# ------------------------------------------------------------------
if ! git remote get-url origin >/dev/null 2>&1; then
  command -v gh >/dev/null || die "GitHub CLI kurulu değil:  sudo apt install gh   (sonra tekrar: bash sync.sh)"
  interactive || die "İlk kurulum etkileşimli olmalı: bash $SCRIPT_PATH"

  if ! gh auth status >/dev/null 2>&1; then
    say "GitHub'a giriş yapılıyor (tarayıcı açılacak)..."
    # Token keyring yerine dosyada dursun ki cron'dan da push yapılabilsin
    if gh auth login --help 2>/dev/null | grep -q -- '--insecure-storage'; then
      gh auth login --hostname github.com --git-protocol https --web --insecure-storage
    else
      gh auth login --hostname github.com --git-protocol https --web
    fi
  fi
  gh auth setup-git

  say "GitHub'da '$REPO_NAME' deposu oluşturuluyor ($VISIBILITY)..."
  gh repo create "$REPO_NAME" "--$VISIBILITY" \
     --description "Siber güvenlik öğrenme notlarım — Obsidian'dan otomatik senkronize edilir" \
     --source=. --remote=origin --push
  say "Hazır: $(gh repo view "$REPO_NAME" --json url -q .url)"
else
  # İnternet yoksa sessizce çık; bir sonraki çalıştırmada tekrar denenir
  if ! git fetch -q origin 2>/dev/null; then
    say "GitHub'a ulaşılamadı, commit'ler yerelde bekliyor; sonra tekrar denenecek."
    exit 0
  fi
  # GitHub'da web arayüzünden bir şey düzenlendiyse önce onu al
  if git rev-parse -q --verify "origin/$BRANCH" >/dev/null \
     && ! git rebase -q --autostash "origin/$BRANCH" >/dev/null 2>&1; then
    git rebase --abort 2>/dev/null || true
    die "GitHub'daki değişikliklerle çakışma var. Elle çöz: cd $NOTEBOOK_DIR && git pull --rebase"
  fi
  if ! git rev-parse -q --verify "origin/$BRANCH" >/dev/null \
     || [ -n "$(git log "origin/$BRANCH..HEAD" --oneline)" ]; then
    git push -q origin "$BRANCH" \
      || die "GitHub'a gönderilemedi (giriş/token sorunu olabilir). Commit'ler yerelde bekliyor."
    say "GitHub'a gönderildi."
  fi
fi

# ------------------------------------------------------------------
# 5) Otomatik senkron (cron) — ilk kurulumda bir kez sorulur
# ------------------------------------------------------------------
if interactive && ! crontab -l 2>/dev/null | grep -qF "$SCRIPT_PATH"; then
  read -rp "Saatte bir otomatik senkron kurulsun mu? [E/h] " ans
  if [[ ! "$ans" =~ ^[HhNn] ]]; then
    mkdir -p "$(dirname "$LOG_FILE")"
    ( crontab -l 2>/dev/null; echo "0 * * * * /usr/bin/env bash $SCRIPT_PATH >> $LOG_FILE 2>&1" ) | crontab -
    say "Tamam. Her saat başı otomatik gönderilecek (log: $LOG_FILE)."
  fi
fi
