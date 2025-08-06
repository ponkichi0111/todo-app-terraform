events {}

http {
  server {
    listen 80;

    location /health {
      return 200 "OK\n";
      add_header Content-Type text/plain;
    }

    location / {
      root /usr/share/nginx/html;
      index index.html;
    }

    location /todos {
      proxy_pass http://${ALB_DNS}/;
    }
  }
}
