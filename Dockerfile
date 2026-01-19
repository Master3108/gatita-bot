# Usar imagen base ligera de Nginx
FROM nginx:alpine

# Copiar el archivo HTML principal directamente como index.html
COPY chat-gatita-v2.html /usr/share/nginx/html/index.html

# Exponer el puerto 80
EXPOSE 80

# Iniciar Nginx
CMD ["nginx", "-g", "daemon off;"]
