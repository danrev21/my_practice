#!/bin/bash

#install docker
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

#configure myweb image
mkdir mydocker && cd mydocker
cat > Dockerfile << EOF
FROM nginx
EXPOSE 80
RUN echo "<!DOCTYPE html> \
<html lang="ru"> \
  <head> \
    <meta charset="utf-8"> \
    </head> \
    <body style='background-color:green;'> \
      <style> \
	body { background: url(https://images.wallpaperscraft.ru/image/single/kraska_granzh_zelenyj_124502_1920x1080.jpg); } \
      </style> \
      <div style='text-align:center; color: white;'> \
      <h1><i>TEXT<i></h1> \
      <h2>TEXT</h2> \
      <h2>TEXT</h2> \ 
      <h2>TEXT</h2> \
      <form action="https://cdn.lifehacker.ru/wp-content/uploads/2015/09/ne_boisya_1440-1280_1465556365-1140x1283.png" target="_blank"> \
      <button>PUSH</button> \
      </form> \
      <form action="https://images.wallpaperscraft.ru/image/single/nadpis_motivatsiya_temnyj_fon_tekstura_119598_480x800.jpg" target="_blank"> \
      <button>PUSH</button> \
      </form> \
      <form action="https://minsknews.by/wp-content/uploads/2016/04/4-copy-3.jpg" target="_blank"> \
      <button>PUSH</button> \
      </form> \
      <form action="https://images.wallpaperscraft.ru/image/single/nadpis_tekst_motivatsiya_chernyj_fon_119760_480x800.jpg" target="_blank"> \
      <button>PUSH</button> \
      </form> \
      <form action="https://abrakadabra.fun/uploads/posts/2022-02/1644299525_10-abrakadabra-fun-p-motivatsionnie-oboi-dlya-telefona-na-russk-15.jpg" target="_blank"> \
      <button>PUSH</button> \
      </form> \
      </div> \
    </body> \
</html>" > /usr/share/nginx/html/index.html
CMD nginx -g 'daemon off;'
EOF
sudo docker build -t myweb .

#run container myweb
sudo docker run -d --name myapp1 -p 777:80 myweb:latest

sudo su && echo 'myapp1.zapto.org   localhost' >> /etc/hosts
systemctl restart systemd-networkd
