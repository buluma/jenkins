FROM ubuntu:latest

# set maintainer
LABEL maintainer "me@buluma.me.ke"

# set a health check
HEALTHCHECK --interval=5s \
            --timeout=5s \
            CMD curl -f http://127.0.0.1:8000 || exit 1

#EXPOSE 80
EXPOSE 8000
