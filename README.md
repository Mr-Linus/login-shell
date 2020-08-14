# SSH登录脚本
![alt](/ssh.jpg)
## 添加登录启动功能

    cd login-shell
  
    mv motd.sh /etc/
  
    chmod 755 /etc/motd.sh
  
    echo 'sh /etc/motd.sh' >> /etc/profile
