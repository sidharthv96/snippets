# Collection of frequently used snippets

## Install Fish
```
apt get install fish -y
curl -L https://get.oh-my.fish | fish
```

## Speed Test

`curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -`

## Add SSH public key
```
mkdir ~/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC50rvJls7Z4y82GhF8vqUKXvP6uffT9xL0qjCYFSNM8IpOpBiBuci7S+lFhovooiGtKsT+uY1W1q0KEitqlcnMldQPB3eVwvFpjs/Mxs5AKUvpvw3HpsrKRYJSsWywhQlLzMMWtBexvosnmhLcsLJzaRPbsZEyXH+qX4SWjNMtmxNa3nLDfCZcS1NO83nLlxXMxwNO1Kb3+bo2lROO0dmvK0gvOK0DQBkbhAlOg1VHoDjdmbDujrV/5mpcwgnLVXwC12DXzh6dgKmkakWdjyqmsuKkc9tLipYMS9UwqJ/PsuFh3+BIcFnsmn/I3HktJADTDhwGYOSDIuoweurB/wjH sidharthvinod@Sidharths-Air.Home" >> ~/.ssh/authorized_keys
```

## WiFi and SSH Headless Raspberry PI Setup 
```
touch /Volumes/boot/ssh
echo "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=IN

network={
    ssid=\"Hacker\"
    psk=\"password\"
    key_mgmt=WPA-PSK
}" > /Volumes/boot/wpa_supplicant.conf
```
