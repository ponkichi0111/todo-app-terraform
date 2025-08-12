events {}

http {
  include /etc/nginx/mime.types;
  default_type application/octet-stream;

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
      proxy_pass http://127.0.0.1:4000;
    }
  }
  gzip on;
  gzip_types text/plain text/css application/javascript application/json;
  gzip_min_length 1000;
  gzip_vary on;
  gzip_comp_level 6;
  gzip_proxied any;
}
