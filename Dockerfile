FROM python:2.7
MAINTAINER Chris Kretler "ckretler@umich.edu"

RUN echo 'root:root' | chpasswd
#RUN chmod 4755 /bin/su
RUN chmod 644 /etc/shadow

RUN apt-get update -y && apt-get install -y \
  ssh

WORKDIR /app

COPY . .

RUN pip install -r requirements.txt

#RUN chown -R www-data /app
#USER www-data
RUN chmod g+r -R wsgi.py ./welcome

EXPOSE 8000

CMD ["gunicorn", "-c", "guniconf", "wsgi:application"]
