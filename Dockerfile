# Usar imagen base ligera de Nginx
FROM nginx:alpine

# Copiar los archivos de la carpeta del agente al directorio web de Nginx
COPY agente-manager-gatitaloca /usr/share/nginx/html

# Renombrar el archivo principal a index.html para que cargue por defecto
RUN mv /usr/share/nginx/html/chat-gatita-gemini-style.html /usr/share/nginx/html/index.html

# Configuración opcional para SPA (Single Page Application) si fuera necesario
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# Exponer el puerto 80
EXPOSE 80

# Iniciar Nginx
CMD ["nginx", "-g", "daemon off;"]
