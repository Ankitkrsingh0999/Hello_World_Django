FROM python:3.6
ENV PYTHONUNBUFFERED 1
RUN mkdir /code
WORKDIR /code
ADD requirements.txt /code/
RUN pip install -r requirements.txt
RUN pip install awscli --upgrade
# ADD projectile /code/
#RUN usermod -a -G ${docker} ${jenkins}
#USER ${jenkins}
