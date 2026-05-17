#!/bin/bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── Colors ────────────────────────────────────────────────────────────────────
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; RESET='\033[0m'

info()    { echo -e "${CYAN}→${RESET} $*"; }
success() { echo -e "${GREEN}✓${RESET} $*"; }
warn()    { echo -e "${YELLOW}!${RESET} $*"; }
error()   { echo -e "${RED}✗${RESET} $*"; }

echo -e "\n${BOLD}omarchy-tui-theme installer${RESET}\n"

# ── Check Omarchy ─────────────────────────────────────────────────────────────
if [[ ! -d "$HOME/.local/share/omarchy" ]]; then
  error "Omarchy is not installed."
  echo "  Install it first: https://github.com/basecamp/omarchy"
  exit 1
fi

# ── Check Walker ──────────────────────────────────────────────────────────────
if [[ ! -d "$HOME/.config/walker" ]]; then
  warn "Walker config directory not found at ~/.config/walker"
  warn "Walker menus will be skipped. Install Walker to use them."
  SKIP_WALKER=true
else
  SKIP_WALKER=false
fi

echo ""

# ── 1. Aether theme ───────────────────────────────────────────────────────────
info "Installing Aether theme..."
mkdir -p "$HOME/.config/omarchy/themes"
cp -r "$REPO_DIR/theme/aether" "$HOME/.config/omarchy/themes/"
success "Aether theme installed"

# ── 2. Walker TUI themes ──────────────────────────────────────────────────────
if [[ "$SKIP_WALKER" == false ]]; then
  info "Installing Walker TUI themes..."
  mkdir -p "$HOME/.config/walker/themes"
  cp -r "$REPO_DIR/walker/themes/omarchy-default" "$HOME/.config/walker/themes/"
  cp -r "$REPO_DIR/walker/themes/omarchy-menu"    "$HOME/.config/walker/themes/"
  cp -r "$REPO_DIR/walker/themes/omarchy-apps"    "$HOME/.config/walker/themes/"
  success "Walker themes installed (omarchy-default, omarchy-menu, omarchy-apps)"
fi

# ── 3. Walker config ──────────────────────────────────────────────────────────
if [[ "$SKIP_WALKER" == false ]]; then
  if [[ -f "$HOME/.config/walker/config.toml" ]]; then
    warn "Walker config already exists at ~/.config/walker/config.toml"
    echo -n "   Overwrite? [y/N]: "
    read -r walker_cfg_choice
    if [[ "${walker_cfg_choice,,}" == "y" ]]; then
      cp "$REPO_DIR/walker/config.toml" "$HOME/.config/walker/config.toml"
      success "Walker config installed"
    else
      warn "Walker config skipped"
    fi
  else
    cp "$REPO_DIR/walker/config.toml" "$HOME/.config/walker/config.toml"
    success "Walker config installed"
  fi
fi

# ── 5. Walker override ────────────────────────────────────────────────────────
if [[ "$SKIP_WALKER" == false ]]; then
  info "Installing Walker override..."
  mkdir -p "$HOME/.config/omarchy/overrides"
  cp "$REPO_DIR/overrides/omarchy-launch-walker" "$HOME/.config/omarchy/overrides/"
  chmod +x "$HOME/.config/omarchy/overrides/omarchy-launch-walker"
  success "Walker override installed"
fi

# ── 6. Screensaver branding ───────────────────────────────────────────────────
echo ""
warn "The screensaver ASCII art in branding/screensaver.txt contains the original author's name."
echo -e "   ${BOLD}Options:${RESET}"
echo "     [1] Keep it as-is"
echo "     [2] Open editor to customize it now"
echo "     [3] Skip screensaver"
echo -n "   Choice [1/2/3]: "
read -r choice

case "$choice" in
  2)
    mkdir -p "$HOME/.config/omarchy/branding"
    cp "$REPO_DIR/branding/screensaver.txt" "$HOME/.config/omarchy/branding/screensaver.txt"
    "${EDITOR:-nano}" "$HOME/.config/omarchy/branding/screensaver.txt"
    success "Screensaver branding saved"
    ;;
  3)
    warn "Screensaver skipped"
    ;;
  *)
    mkdir -p "$HOME/.config/omarchy/branding"
    cp "$REPO_DIR/branding/screensaver.txt" "$HOME/.config/omarchy/branding/screensaver.txt"
    success "Screensaver branding installed (edit later: omarchy branding screensaver text)"
    ;;
esac

# ── 7. Waybar ─────────────────────────────────────────────────────────────────
echo ""
warn "Installing Waybar config will REPLACE your existing ~/.config/waybar/style.css and config.jsonc."
echo -n "   Install Waybar config? [y/N]: "
read -r waybar_choice

if [[ "${waybar_choice,,}" == "y" ]]; then
  mkdir -p "$HOME/.config/waybar"
  cp "$REPO_DIR/waybar/style.css"    "$HOME/.config/waybar/"
  cp "$REPO_DIR/waybar/config.jsonc" "$HOME/.config/waybar/"
  success "Waybar config installed"
else
  warn "Waybar skipped"
fi

# ── 8. Activate theme ─────────────────────────────────────────────────────────
echo ""
info "Activating Aether theme..."
if command -v omarchy &>/dev/null; then
  omarchy theme set aether
  success "Aether theme activated"
else
  warn "Could not run 'omarchy theme set aether' — activate it manually from the Omarchy menu"
fi

# ── Done ──────────────────────────────────────────────────────────────────────
echo ""
echo -e "${GREEN}${BOLD}Installation complete!${RESET}"
echo ""
echo "  SUPER+SPACE         → Apps launcher (TUI)"
echo "  SUPER+ALT+SPACE     → Omarchy menu (TUI)"
echo ""
echo "  To change screensaver art: omarchy branding screensaver text"
echo ""
