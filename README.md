# Ubuntu 24.04 极致 Bash 增强方案（纯 Bash，不用 zsh）

让你的 Bash 比 90% 人的 zsh + oh-my-zsh 还好用！

## 安装效果（一键后获得）

| 工具       | 替代命令 | 功能亮点                              |
|------------|----------|---------------------------------------|
| eza        | ls       | 颜色 + 图标 + git 状态                 |
| bat        | cat      | 语法高亮 + 行号 + git 状态             |
| rg         | grep     | 超快 + 自动忽略 .gitignore             |
| fd         | find     | 语法简单 + 超快 + 自动忽略             |
| fzf        | Ctrl+T/R | 文件/历史命令模糊搜索                  |
| zoxide     | z        | 智能跳转目录（越常用越靠前）           |
| starship   | 提示符   | 极速、美观的跨 shell 提示符            |
| atuin      | Ctrl+R   | 历史命令数据库 + 模糊搜索 + 云同步     |

## 一键安装（推荐）

```bash
wget https://raw.githubusercontent.com/你的用户名/dotfiles/main/setup-ubuntu24-bash.sh
chmod +x setup-ubuntu24-bash.sh
./setup-ubuntu24-bash.sh
source ~/.bashrc
