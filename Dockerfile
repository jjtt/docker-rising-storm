FROM bitr/empyrion-server

EXPOSE 8080
EXPOSE 7787
EXPOSE 27015

RUN ln -s /home/user/linux32/steamclient.so /home/user/linux32/steamservice.so
ADD entrypoint.sh /
USER user
ENTRYPOINT ["/entrypoint.sh"]
