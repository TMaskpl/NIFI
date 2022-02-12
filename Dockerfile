FROM apache/nifi 

USER root

RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo \
    python3-dev \
    git \ 
    python3-pip \
    net-tools \
    cron

RUN pip3 install ansible pywinrm psycopg2-binary requests beautifulsoup4 lxml pandas 

RUN usermod -aG sudo nifi 

RUN  echo 'nifi:password' | chpasswd

RUN sed -i'' -e's/^#PasswordAuthentication yes$/PasswordAuthentication yes/' /etc/ssh/sshd_config

RUN service ssh start

EXPOSE 8443 
EXPOSE 22

USER nifi

RUN mkdir -p /opt/nifi/TMask

RUN chmod 777 -R /opt/nifi/TMask

CMD ["/opt/nifi/scripts/start.sh"]
