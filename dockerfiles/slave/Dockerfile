FROM jmeterbase:v1

RUN ln -s /opt/apache-jmeter-${JMETER_VERSION}/bin/jmeter-server /usr/local/bin
EXPOSE 1099 50000

ENTRYPOINT $JMETER_HOME/bin/jmeter-server \
-Dserver.rmi.localport=50000 \
-Dserver_port=1099