#!/bin/bash
export PATH="/mnt/c/Windows/System32/WindowsPowerShell/v1.0/:$PATH"

# 调用Windows的ipconfig命令并解析WLAN适配器的IPv4地址
wifi_ip=$(powershell.exe ipconfig | grep -A 4 'Wireless LAN adapter WLAN:' | grep 'IPv4 Address' | awk '{print $NF}' | tr -d '\r')

# 指定代理端口
proxy_port="7890"

# 检查是否成功获取到IP地址
if [ -n "$wifi_ip" ]; then
    echo "Your Windows WLAN IPv4 address is: $wifi_ip"

    # 构建代理字符串
    proxy="http://${wifi_ip}:${proxy_port}"

    # 添加或更新环境变量到/etc/environment
    sudo sed -i '/http_proxy=/d' /etc/environment
    sudo sed -i '/https_proxy=/d' /etc/environment
    sudo sed -i '/ftp_proxy=/d' /etc/environment
    sudo sed -i '/no_proxy=/d' /etc/environment

    echo "http_proxy=\"$proxy\"" | sudo tee -a /etc/environment >/dev/null
    echo "https_proxy=\"$proxy\"" | sudo tee -a /etc/environment >/dev/null
    echo "ftp_proxy=\"$proxy\"" | sudo tee -a /etc/environment >/dev/null
    echo "no_proxy=\"localhost,127.0.0.1,::1\"" | sudo tee -a /etc/environment >/dev/null

    source /etc/environment
    echo "Proxy environment variables have been set."
else
    echo "Failed to get the Windows WLAN IPv4 address."
fi
