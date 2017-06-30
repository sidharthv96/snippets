echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC50rvJls7Z4y82GhF8vqUKXvP6uffT9xL0qjCYFSNM8IpOpBiBuci7S+lFhovooiGtKsT+uY1W1q0KEitqlcnMldQPB3eVwvFpjs/Mxs5AKUvpvw3HpsrKRYJSsWywhQlLzMMWtBexvosnmhLcsLJzaRPbsZEyXH+qX4SWjNMtmxNa3nLDfCZcS1NO83nLlxXMxwNO1Kb3+bo2lROO0dmvK0gvOK0DQBkbhAlOg1VHoDjdmbDujrV/5mpcwgnLVXwC12DXzh6dgKmkakWdjyqmsuKkc9tLipYMS9UwqJ/PsuFh3+BIcFnsmn/I3HktJADTDhwGYOSDIuoweurB/wjH sidharthvinod@Sidharths-Air.Home" >> ~/.ssh/authorized_keys
sudo yum groupinstall -y "Development Tools"
sudo yum install -y wget nano git python-pip python-devel postgresql-server postgresql-devel postgresql-contrib gcc nginx zsh
sudo usermod -a -G ec2-user nginx
chmod 710 /home/ec2-user
wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-9.noarch.rpm
sudo rpm -ivh epel-release-7-9.noarch.rpm
rm epel-release-7-9.noarch.rpm
sudo pip install --upgrade pip
sudo pip install virtualenv virtualenvwrapper
mkdir ~/.virtualenvs
chsh -s /bin/zsh ec2-user
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
echo "export WORKON_HOME=~/.virtualenvs" >> ~/.zshrc
echo ". /usr/bin/virtualenvwrapper.sh" >> ~/.zshrc
echo "alias pm='python manage.py'" >> ~/.zshrc
source ~/.zshrc
ssh-keygen
mkvirtualenv taxi
pip install django gunicorn psycopg2

sudo postgresql-setup initdb
sudo systemctl start postgresql
# Change ident to md5
sudo nano /var/lib/pgsql/data/pg_hba.conf
sudo systemctl restart postgresql
sudo systemctl enable postgresql

sudo su - postgres

#Do inside
psql