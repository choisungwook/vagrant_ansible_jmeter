# Use vinsdocker base image
FROM base:v1

RUN sed -i s/#server.rmi.ssl.disable=false/server.rmi.ssl.disable=true/g -i $JMETER_HOME/bin/jmeter.properties
RUN sed -i s/#server.rmi.localport=4000/server.rmi.localport=4000/g -i $JMETER_HOME/bin/jmeter.properties 
RUN sed -i s/#server_port=1099/server_port=4000/g -i $JMETER_HOME/bin/jmeter.properties 