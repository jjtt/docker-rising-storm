FROM bitr/empyrion-server

EXPOSE 7787
EXPOSE 27015

ADD entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
