#FROM debian:wheezy
FROM debian:jessie
MAINTAINER daniel@kuecker.net

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y git-core libfreetype6 libfreetype6-dev patch python-mysqldb python-setuptools 
RUN apt-get install -y python-subvertpy memcached python-imaging python-pip python-dev subversion mercurial python-svn libpcre3 
RUN apt-get install -y libpcre3-dev python-ldap libc6 libtiff5-dev zlib1g-dev libfreetype6-dev liblcms2-dev libwebp-dev
RUN apt-get install -y python-tk libffi-dev nano wget sudo libjpeg62-turbo-dev libssl-dev

RUN wget -qO - http://package.perforce.com/perforce.pubkey | sudo apt-key add -
RUN echo 'deb http://package.perforce.com/apt/ubuntu wheezy release' > /etc/apt/sources.list.d/perforce.list
RUN apt-get update
RUN apt-get install -y perforce-cli perforce-p4python-python2.7

RUN pip install pyasn1 --upgrade

RUN easy_install reviewboard

RUN pip install -U uwsgi

ADD start.sh /start.sh
ADD uwsgi.ini /uwsgi.ini
ADD shell.sh /shell.sh

RUN chmod +x start.sh shell.sh

VOLUME ["/.ssh", "/media/"]

EXPOSE 8000

CMD /start.sh
