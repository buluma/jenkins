FROM alpine:latest

# set maintainer
LABEL maintainer "me@buluma.me.ke"
LABEL build_date="2022-05-22"

RUN apk update && \
    apk upgrade 
RUN apk add openjdk8-jre

RUN apk add gcc git-core python3-devel python3-libselinux python3-jmespath python3-pip

ADD requirements.txt /requirements.txt
RUN python -m pip install -r /requirements.txt

# set a health check
HEALTHCHECK --interval=5s \
            --timeout=5s \
            CMD curl -f http://127.0.0.1:8000 || exit 1

#EXPOSE 80
EXPOSE 8000
