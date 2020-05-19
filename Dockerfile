FROM centos:7.8.2003
LABEL maintainer="xplat.fpt.com.vn" version="10"


RUN curl "https://raw.githubusercontent.com/pwnlabs/oracle-instantclient/master/oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm" -o /tmp/oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm \
    && curl "https://omnidb.org/dist/2.17.0/omnidb-server_2.17.0-centos7-amd64.rpm" -o /tmp/omnidb-server_2.17.0-centos7-amd64.rpm

#also you can download *.rpm locally first.
#COPY oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm /tmp
#COPY omnidb-server_2.16.0-centos7-amd64.rpm /tmp


RUN yum -y update \
      && yum -y install /tmp/omnidb-server_2.17.0-centos7-amd64.rpm  \
	  && yum -y install /tmp/oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm \
      && mkdir -p /etc/omnidb && chmod -R 777 /etc/omnidb

RUN yum install -y pwgen wget logrotate bind-utils net-tools which lsof telnet supervisor

ENV LD_LIBRARY_PATH /usr/lib/oracle/12.2/client64/lib

EXPOSE 8888 8080 
EXPOSE 8000

ENTRYPOINT ["omnidb-server", "-p", "8080", "-w", "8888", "-e", "8000", "-d", "/etc/omnidb", "-H", "0.0.0.0"]
