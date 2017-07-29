echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC50rvJls7Z4y82GhF8vqUKXvP6uffT9xL0qjCYFSNM8IpOpBiBuci7S+lFhovooiGtKsT+uY1W1q0KEitqlcnMldQPB3eVwvFpjs/Mxs5AKUvpvw3HpsrKRYJSsWywhQlLzMMWtBexvosnmhLcsLJzaRPbsZEyXH+qX4SWjNMtmxNa3nLDfCZcS1NO83nLlxXMxwNO1Kb3+bo2lROO0dmvK0gvOK0DQBkbhAlOg1VHoDjdmbDujrV/5mpcwgnLVXwC12DXzh6dgKmkakWdjyqmsuKkc9tLipYMS9UwqJ/PsuFh3+BIcFnsmn/I3HktJADTDhwGYOSDIuoweurB/wjH sidharthvinod@Sidharths-Air.Home" >> ~/.ssh/authorized_keys
sudo yum groupinstall -y "Development Tools"
sudo yum install -y wget nano git gcc-c++ pcre-devel zlib-devel make unzip python-pip python-devel postgresql-server postgresql-devel postgresql-contrib zsh screen

#NGINX and Pagespeed
NPS_VERSION=1.12.34.2
NGINX_VERSION=1.12.1
wget "http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz"
wget "https://github.com/pagespeed/ngx_pagespeed/archive/v${NPS_VERSION}-stable.tar.gz"
tar -xzf nginx-${NGINX_VERSION}.tar.gz
tar -xzf v${NPS_VERSION}-stable.tar.gz
cd ngx_pagespeed-${NPS_VERSION}-stable
psol_url=https://dl.google.com/dl/page-speed/psol/${NPS_VERSION}.tar.gz
[ -e scripts/format_binary_url.sh ] && psol_url=$(scripts/format_binary_url.sh PSOL_BINARY_URL)
wget ${psol_url}
tar -xzvf $(basename ${psol_url})
cd ../nginx-${NGINX_VERSION}
./configure --add-module=$HOME/ngx_pagespeed-${NPS_VERSION}-stable --user=nobody --group=nobody --pid-path=/var/run/nginx.pid ${PS_NGX_EXTRA_FLAGS}
sudo make
sudo make install
sudo ln -s /usr/local/nginx/conf/ /etc/nginx
sudo ln -s /usr/local/nginx/sbin/nginx /usr/sbin/nginx

# Add content from https://www.nginx.com/resources/wiki/start/topics/examples/redhatnginxinit/
# Change "/etc/nginx/nginx.conf" to "/etc/nginx/conf/nginx.conf"

sudo nano /etc/init.d/nginx
sudo chmod +x /etc/init.d/nginx
sudo service nginx start
sudo systemctl enable nginx
sudo mkdir -p /var/ngx_pagespeed_cache
sudo chown -R nobody:nobody /var/ngx_pagespeed_cache
sudo nano /etc/nginx/conf/nginx.conf

# Add the following lines
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##
# Pagespeed main settings

pagespeed on;
pagespeed FileCachePath /var/ngx_pagespeed_cache;

# Ensure requests for pagespeed optimized resources go to the pagespeed
# handler and no extraneous headers get set.

location ~ "\.pagespeed\.([a-z]\.)?[a-z]{2}\.[^.]{10}\.[^.]+" { add_header "" ""; }
location ~ "^/ngx_pagespeed_static/" { }
location ~ "^/ngx_pagespeed_beacon" { }

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

sudo systemctl restart nginx

sudo usermod -a -G ec2-user nobody
chmod 710 /home/ec2-user
wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-9.noarch.rpm
sudo rpm -ivh epel-release-7-9.noarch.rpm
rm epel-release-7-9.noarch.rpm
curl -sL https://raw.githubusercontent.com/brainsik/virtualenv-burrito/master/virtualenv-burrito.sh | $SHELL
chsh -s /bin/zsh ec2-user
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
echo "export PROJECT_HOME=~/" >> ~/.zshrc
echo "source ~/.venvburrito/startup.sh" >> ~/.zshrc
echo "alias pm='python manage.py'" >> ~/.zshrc
echo "defscrollback 5000\ntermcapinfo xterm* ti@:te@" > ~/.screenrc
source ~/.zshrc
ssh-keygen

#SWAP of 2GB
sudo dd if=/dev/zero of=/swapfile bs=1024 count=2097152
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
swapon -s
sudo su
echo "/swapfile   swap    swap    sw  0   0">> /etc/fstab


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
