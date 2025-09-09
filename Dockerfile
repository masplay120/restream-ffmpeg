FROM jrottenberg/ffmpeg:4.4-ubuntu

COPY start.sh /start.sh
RUN chmod +x /start.sh

ENTRYPOINT ["/bin/bash", "/start.sh"]
