# Should be run like this (from the repo root):
# sudo docker run -v `pwd`:/home/elasticboard -p 8080:80 -p 5000:5000 -i -t elasticboard
#                                                ^^^^       ^^^^
#                                            you can change these

FROM dockerfile/elasticsearch

RUN apt-get update
RUN apt-get install -y nginx-full python python-pip python-dev
RUN apt-get install -y bash

ADD data_processor/requirements-pip /root/requirements-pip
RUN pip install -r /root/requirements-pip

EXPOSE 80

/usr/share/elasticsearch/bin/plugin -i com.ubervu/elasticsearch-river-github/1.4.2

# copy nginx configs
ADD docker_configs/dashboard /etc/nginx/sites-available/dashboard
RUN ln -s /etc/nginx/sites-available/dashboard /etc/nginx/sites-enabled/dashboard
RUN rm /etc/nginx/sites-enabled/default

RUN chmod o+rx /root

# es config
ADD docker_configs/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml

CMD /usr/sbin/useradd --create-home --shell /bin/bash elasticboard
ADD docker_configs/sudoers /etc/sudoers

USER elasticboard

# fire away
CMD true && sudo service elasticsearch start &&\
     sudo service nginx start &&\
     cd ~ &&\
     python docker_configs/change_host.py config.json &&\
     python init_rivers.py &&\
     /usr/local/bin/gunicorn -w 4 -b 0.0.0.0:5000 data_processor.api:app

#ENTRYPOINT "/bin/bash"
