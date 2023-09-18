FROM httpd:2.4

# Копіюємо index.html до директорії Apache
COPY index.html /usr/local/apache2/htdocs/

# Встановлюємо модуль proxy_http для Apache
RUN sed -i '/LoadModule proxy_module/s/^#//g' /usr/local/apache2/conf/httpd.conf && \
    sed -i '/LoadModule proxy_http_module/s/^#//g' /usr/local/apache2/conf/httpd.conf

# Налаштовуємо проксі-переадресацію для API
RUN echo 'ProxyPass "/api" "http://localhost:9007"' >> /usr/local/apache2/conf/httpd.conf