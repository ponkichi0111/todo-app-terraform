FROM nginx:alpine

WORKDIR /usr/share/nginx/html

# 静的ファイルの配置
COPY index.html .
COPY script.js .

RUN chmod 644 /usr/share/nginx/html/*

# Nginx 設定ファイルを上書き
COPY nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]