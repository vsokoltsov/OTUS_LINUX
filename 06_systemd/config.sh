# TASK 1

sudo cp 30_seconds_log /etc/sysconfig/
sudo cp 30_seconds_log.service 30_seconds_log.timer /etc/systemd/system/
sudo cp timer.sh /tmp/timer.sh

sudo chmod a+x /tmp/timer.sh

sudo systemctl daemon-reload
sudo systemctl start 30_seconds_log
sudo systemctl enable 30_seconds_log

# Task 2

sudo yum -y install epel-release