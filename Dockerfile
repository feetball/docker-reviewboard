FROM debian:jessie
MAINTAINER daniel@kuecker.net

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y git-core libfreetype6 libfreetype6-dev patch python-mysqldb python-setuptools 
RUN apt-get install -y python-subvertpy memcached python-imaging python-pip python-dev subversion mercurial python-svn libpcre3 
RUN apt-get install -y libpcre3-dev python-ldap libc6 libtiff5-dev zlib1g-dev libfreetype6-dev liblcms2-dev libwebp-dev
RUN apt-get install -y python-tk libffi-dev nano wget sudo

#RUN apt-get -t testing install libjpeg8 libjpeg8-dev libjpeg62-dev


RUN easy_install reviewboard

RUN pip install -U uwsgi

ADD start.sh /start.sh
ADD uwsgi.ini /uwsgi.ini
ADD shell.sh /shell.sh

RUN chmod +x start.sh shell.sh

VOLUME ["/.ssh", "/media/"]

EXPOSE 8000

CMD /start.sh
