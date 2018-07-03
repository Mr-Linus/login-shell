# 极云 SSH登录脚本
![alt](https://github.com/StarWars-Team/geekcloud-ssh/blob/master/ssh.jpg)
## 添加登录启动功能
    git clone https://github.com/StarWars-Team/login-shell.git
  
    cd geekcloud-ssh
  
    mv motd.sh /etc/
  
    chmod 755 /etc/motd.sh
  
    echo 'sh /etc/motd.sh' >> /etc/profile
