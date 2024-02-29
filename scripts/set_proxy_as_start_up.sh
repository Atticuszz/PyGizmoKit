#!/bin/bash

# 确保/root/scripts/目录存在
mkdir -p /root/scripts/

# 使用wget下载脚本
wget -O /root/scripts/set_proxy.sh https://raw.githubusercontent.com/Atticuszz/PyGizmoKit/main/scripts/get_proxy_ip.sh

# 给下载的脚本执行权限
chmod +x /root/scripts/set_proxy.sh

# 创建Systemd服务文件
cat <<EOF | sudo tee /etc/systemd/system/set_proxy.service
[Unit]
Description=Set Proxy Environment Variables at Startup

[Service]
ExecStart=/bin/bash /root/scripts/set_proxy.sh

[Install]
WantedBy=multi-user.target
EOF

# 重新加载Systemd管理器配置
sudo systemctl daemon-reload

# 启用服务
sudo systemctl enable set_proxy.service

# 启动服务来测试
sudo systemctl start set_proxy.service

echo "Service set_proxy has been created and started."
