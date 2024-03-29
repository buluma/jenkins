FROM buluma/docker-fedora35-ansible

# set maintainer
LABEL maintainer "me@buluma.me.ke"
LABEL build_date="2022-05-22"
ENV container=docker

WORKDIR /home/jenkins/agent

RUN dnf -y install java-11-openjdk-devel git-all make gcc sudo gnupg

ADD requirements.txt /requirements.txt
RUN python -m pip install -r /requirements.txt

# Setup Docker
RUN sudo dnf -y remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine

RUN sudo dnf -y install dnf-plugins-core

RUN sudo dnf config-manager \
    --add-repo \
    https://download.docker.com/linux/fedora/docker-ce.repo
    
RUN sudo dnf -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin

# set a health check
HEALTHCHECK --interval=5s \
            --timeout=5s \
            CMD curl -f http://127.0.0.1:8000 || exit 1

EXPOSE 8000

CMD []
