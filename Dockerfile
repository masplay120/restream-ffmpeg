FROM jrottenberg/ffmpeg:4.4-ubuntu

# Copiar script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Sobrescribir el entrypoint de la imagen
ENTRYPOINT []
CMD ["/bin/bash", "/start.sh"]
