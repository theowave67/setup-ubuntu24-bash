#!/usr/bin/env bash
set -euo pipefail

echo "=============== 更新 & 安装核心工具 ==============="
sudo apt update && sudo apt upgrade -y
sudo apt install -y \
    fzf ripgrep fd-find bat eza zoxide curl git bash-completion \
    fonts-powerline python3-pip pipx tealdeer

# bat 链接
sudo ln -sf /usr/bin/batcat /usr/local/bin/bat 2>/dev/null || true

echo "=============== 安装 Starship ==============="
curl -sS https://starship.rs/install.sh | sh -s -- -y

echo "=============== 安装 tldr（优先 pipx → tealdeer 兜底）==============="
# 方案1：pipx（最优雅）
if command -v pipx >/dev/null 2>&1; then
    pipx ensurepath >/dev/null 2>&1 || true
    pipx install tldr >/dev/null 2>&1 || true
fi

# 方案2：如果 pipx 没装成，用 --break-system-packages（最快）
if ! command -v tldr >/dev/null 2>&1; then
    pip3 install --user --break-system-packages tldr >/dev/null 2>&1 || true
fi

# 方案3：最终兜底用系统自带的 tealdeer
if ! command -v tldr >/dev/null 2>&1; then
    echo "使用系统自带 tealdeer 作为 tldr"
    ln -sf /usr/bin/tldr ~/.local/bin/tldr 2>/dev/null || true
fi

echo "=============== 安装 Atuin（可选）==============="
read -r -t 10 -p "是否安装 atuin？[Y/n] " ans || ans="y"
[[ "$ans" =~ ^[Yy] ]] && bash <(curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh)

echo "=============== 写入终极 .bashrc ==============="
cat << 'EOF' >> ~/.bashrc

# ==================== Ubuntu 24.04 极致 Bash（2025 终极版）===================

[[ -r /usr/share/bash-completion/bash_completion ]] && . /usr/share/bash-completion/bash_completion

# fzf
[ -f /usr/share/doc/fzf/examples/key-bindings.bash ] && . /usr/share/doc/fzf/examples/key-bindings.bash
[ -f /usr/share/bash-completion/completions/fzf ] && source /usr/share/bash-completion/completions/fzf

# 现代命令
alias ls='eza --icons --git --color=always'
alias ll='eza -l --icons --git'
alias la='eza -la --icons --git'
alias cat='bat --style=plain'
alias grep='rg'
alias find='fd'
alias tldr='tldr --color=always'

eval "$(zoxide init bash)"
eval "$(starship init bash)"
command -v ~/.atuin/bin/atuin >/dev/null && eval "$(~/.atuin/bin/atuin init bash)"

# ==================== 结束 ====================
EOF

echo "大功告成！执行下面这行就立刻生效："
echo "source ~/.bashrc"
