sudo yum update -y
sudo yum install -y epel-release
sudo yum install -y nginx createrepo
sudo cp -f /home/vagrant/rpm_lab/nginx.conf /etc/nginx/
sudo systemctl start nginx
cd /usr/share/nginx/html
sudo rm -rf *
sudo cp /home/vagrant/rpm_lab/ip2w-0.0.1-1.noarch.rpm ./
sudo createrepo /usr/share/nginx/html
sudo createrepo --update /usr/share/nginx/html
