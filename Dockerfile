FROM jrottenberg/ffmpeg:4.4-ubuntu

# Copiamos el script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Ejecutamos con bash, no con ffmpeg
CMD ["/bin/bash", "/start.sh"]
