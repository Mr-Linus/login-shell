# 极云 SSH登录脚本

## 添加登录启动功能
  git clone https://github.com/StarWars-Team/geekcloud-ssh.git
  cd geekcloud-ssh
  mv motd.sh /etc/
  chmod 755 /etc/motd.sh
  echo 'sh /etc/motd.sh' >> /etc/profile
