sudo yum install -y epel-release pam_script

# Task 1
cp /home/vagrant/pam_lab/script.sh /bin/script.sh
sudo echo "session     required     pam_script.so runas=root onsessionopen=/bin/script.sh" >> /etc/pam.d/sshd

# Task 2
echo "cap_sys_admin vagrant" >> /etc/security/capability.conf
ex -s -c '2i|auth        optional    pam_cap.so' -c x /etc/pam.d/su
