FROM jmeterbase:v1

EXPOSE 1099 50000

RUN sed -i s/#server.rmi.ssl.disable=false/server.rmi.ssl.disable=true/g /opt/apache-jmeter-5.3/bin/jmeter.properties
ENTRYPOINT /opt/apache-jmeter-5.3/bin/jmeter-server \
-Dserver.rmi.localport=50000 \
-Dserver_port=1099