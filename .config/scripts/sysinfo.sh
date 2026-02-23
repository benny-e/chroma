#!/usr/bin/env bash
set -euo pipefail

THEME="$HOME/.config/rofi/sysinfo.rasi"

host="$(hostnamectl --static 2>/dev/null || hostname)"
kernel="$(uname -r)"
uptime_pretty="$(uptime -p 2>/dev/null | sed 's/^up //')"

cpu="$(lscpu 2>/dev/null | awk -F: '/Model name/ {gsub(/^[ \t]+/, "", $2); print $2; exit}')"
cpu="${cpu:-Unknown}"

mem_total="$(awk '/MemTotal/ {print int($2/1024)}' /proc/meminfo)"
mem_avail="$(awk '/MemAvailable/ {print int($2/1024)}' /proc/meminfo)"
mem_used="$(( mem_total - mem_avail ))"

ip_addr="$(ip -4 route get 1.1.1.1 2>/dev/null | awk '/src/ {for(i=1;i<=NF;i++) if($i=="src"){print $(i+1); exit}}')"
ip_addr="${ip_addr:-N/A}"

shell_name="$(basename "$SHELL")"
pkg_count="$(pacman -Qq 2>/dev/null | wc -l || echo "N/A")"

FG_MAIN="#FFFFFF"
FG_MUTED="#9AA0AA"

HOST_RED="#FF2A1A"      
KERNEL_YELLOW="#F5C542"
UPTIME_FG="#4da6ff"
CPU_FG="#9aafd0"
NET_FG="#00e5ff"
SHELL_FG="#7c86ff"     
PKG_FG="#4DA88B"      

info=$(
cat <<EOF
<span foreground="$HOST_RED">󰌢</span>  <span foreground="$FG_MAIN"><b>Host:   </b></span>  <span foreground="$FG_MUTED">$host</span>
<span foreground="$UPTIME_FG">󰥔</span>  <span foreground="$FG_MAIN"><b>Uptime: </b></span>  <span foreground="$FG_MUTED">$uptime_pretty</span>
<span foreground="$KERNEL_YELLOW">󰌽</span>  <span foreground="$FG_MAIN"><b>Kernel: </b></span>  <span foreground="$FG_MUTED">$kernel</span>
<span foreground="$CPU_FG">󰻠</span>  <span foreground="$FG_MAIN"><b>CPU:    </b></span>  <span foreground="$FG_MUTED">$cpu</span>
<span foreground="$CPU_FG">󰘚</span>  <span foreground="$FG_MAIN"><b>RAM:    </b></span>  <span foreground="$FG_MUTED">${mem_used}MiB / ${mem_total}MiB</span>
<span foreground="$NET_FG">󰈀</span>  <span foreground="$FG_MAIN"><b>IP:     </b></span>  <span foreground="$FG_MUTED">$ip_addr</span>
<span foreground="$SHELL_FG">󰆍</span>  <span foreground="$FG_MAIN"><b>Shell:  </b></span>  <span foreground="$FG_MUTED">$shell_name</span>
<span foreground="$PKG_FG">󰏖</span>  <span foreground="$FG_MAIN"><b>Packages:</b></span> <span foreground="$FG_MUTED">$pkg_count</span>
EOF
)

rofi -e "$info" -markup -theme "$THEME"
