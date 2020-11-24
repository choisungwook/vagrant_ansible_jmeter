# Use vinsdocker base image
FROM base:v1

RUN sed -i s/#server.rmi.ssl.disable=false/server.rmi.ssl.disable=true/g -i $JMETER_HOME/bin/jmeter.properties
RUN sed -i s/#client.rmi.localport=0/client.rmi.localport=4000/g -i $JMETER_HOME/bin/jmeter.properties 
RUN sed -i s/#server.rmi.port=1234/server.rmi.port=4000/g -i $JMETER_HOME/bin/jmeter.properties 