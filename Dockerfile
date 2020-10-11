FROM bitr/empyrion-server

EXPOSE 8080
EXPOSE 7787
EXPOSE 27015

ADD entrypoint.sh /
USER user
ENTRYPOINT ["/entrypoint.sh"]
