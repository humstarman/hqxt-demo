FROM python:3.6.5

ENV DEBIAN_FRONTEND noninteractive
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN apt-get update
RUN apt-get install -y python-pip

COPY requirements.txt /tmp
RUN pip install -r /tmp/requirements.txt

RUN apt-get clean && \ 
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* /usr/share/man /usr/share/doc 

ADD img /static/img/
ADD js /static/js/
ADD app.py /
ADD templates /templates/
ADD entrypoint.sh /
