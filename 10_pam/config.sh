SCRIPT_DIR=/etc/pamscript

sudo yum install -y epel-release
sudo yum install -y pam_script

sudo mkdir $SCRIPT_DIR
sudo chmod o+x $SCRIPT_DIR

cp /home/vagrant/pam_lab/pam_script_ses_open "$SCRIPT_DIR/"
chmod a+x "$SCRIPT_DIR/pam_script_ses_open"

# Create admin user
sudo useradd admin
echo "admin" | passwd admin --stdin

# Task 1
echo "TASK 1"
sudo echo "session     required     pam_script.so dir=$SCRIPT_DIR" >> /etc/pam.d/su
# sudo echo "session     required     pam_script.so dir=$SCRIPT_DIR" >> /etc/pam.d/sshd

# Task 2
echo "TASK 2"
echo "cap_sys_admin vagrant" >> /etc/security/capability.conf
ex -s -c '2i|auth        optional    pam_cap.so' -c x /etc/pam.d/su
