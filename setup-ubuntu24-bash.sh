#!/usr/bin/env bash
# =============================================================================
# Ubuntu 24.04.3 极致 Bash 增强一键安装脚本（纯 apt + 少数官方脚本）
# 作者：你自己（2025）
# 目标：不切换 zsh，纯 Bash 也能丝滑飞起
# =============================================================================

set -euo pipefail

echo "正在更新软件源..."
sudo apt update && sudo apt upgrade -y

echo "安装核心工具（全部来自官方 apt）..."
sudo apt install -y \
    fzf \
    ripgrep \
    fd-find \
    bat \
    eza \
    zoxide \
    curl \
    git \
    bash-completion \
    fonts-powerline \
    nodejs npm

# bat 在 Ubuntu 24.04 包名是 bat，但二进制叫 batcat → 创建常用别名
sudo ln -sf /usr/bin/batcat /usr/local/bin/bat || true

# 安装 starship（官方安装脚本，最快最稳）
echo "安装 Starship 提示符..."
curl -sS https://starship.rs/install.sh | sh -s -- -y

# 安装 atuin（历史命令模糊搜索神器，可选）
echo "安装 Atuin（按回车跳过安装，否则直接回车继续）"
read -r -t 10 -p "是否安装 atuin？(y/N) " install_atuin || install_atuin="n"
if [[ $install_atuin =~ ^[Yy]$ ]]; then
    bash <(curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh)
fi

# 写入 ~/.bashrc 配置（只追加，不覆盖）
echo "写入 ~/.bashrc 配置..."
cat << 'EOF' >> ~/.bashrc

# ==================== 极致 Bash 配置（Ubuntu 24.04+） ====================

# 启用 bash-completion（新系统必备）
[[ -r /usr/share/bash-completion/bash_completion ]] && . /usr/share/bash-completion/bash_completion

# fzf 最新版集成（Ubuntu 24.04 官方包路径）
[ -f /usr/share/doc/fzf/examples/key-bindings.bash ] && source /usr/share/doc/fzf/examples/key-bindings.bash
[ -f /usr/share/doc/fzf/examples/completion.bash ] && source /usr/share/doc/fzf/examples/completion.bash

# 现代命令别名
alias ls='eza --icons --git --color=always'
alias ll='eza -l --icons --git'
alias la='eza -la --icons --git'
alias cat='bat --style=plain'
alias grep='rg'
alias find='fd'

# zoxide（智能 cd）
eval "$(zoxide init bash)"

# starship 提示符
eval "$(starship init bash)"

# atuin（如果安装了的话）
if command -v atuin >/dev/null 2>&1; then
    eval "$(atuin init bash)"
fi

# ==================== 配置结束 ====================
EOF

echo "所有工具安装完成！"
echo "请执行以下命令立即生效："
echo "    source ~/.bashrc"
echo "或者直接重启终端"
echo "享受你的新 Bash 吧！"
