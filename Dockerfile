FROM jrottenberg/ffmpeg:4.4-ubuntu

# Copiamos el script de arranque
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Ejecutar el script al iniciar el contenedor
CMD ["/start.sh"]
