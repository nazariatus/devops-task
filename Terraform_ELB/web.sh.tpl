#!/bin/bash
sudo apt update
sudo apt install nginx -y

sudo echo "<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Multifunctional API | Some Company</title>
</head>
<body>
  <style>
    #api {
      background-color: #ebeae9;
      padding: .5em;
    }
  </style>

  <h1>Hello!</h1>
  <p>We are very proud to release our incredibly multifunctional API!</p>
  <p>Request to an <code>/ring-ring</code> endpoint has returned the following: <code id="api"></code></p>

  <script>
    const xhr = new XMLHttpRequest();
    const res = document.getElementById('api');
    
    xhr.onreadystatechange = res => {
      if (xhr.readyState === XMLHttpRequest.DONE) {
        api.innerText = JSON.stringify(JSON.parse(xhr.responseText));
      }
    };
    
    xhr.open('GET', '/ring-ring');
    xhr.send();
  </script>
</body>
</html>" > /var/www/html/index.nginx-debian.html

sudo echo "server {
        listen 80 default_server;
        listen [::]:80 default_server;

        root /var/www/html;

        index index.html index.htm index.nginx-debian.html;

        server_name _;
   
        location /ring-ring {
        proxy_pass http://${node_public_ip}:9007;
        }

        location / {
        root /var/www/html;
        index index.nginx-debian.html;
        }
}" > /etc/nginx/sites-available/default

sudo systemctl reload nginx