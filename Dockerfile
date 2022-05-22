FROM buluma/centos:systemd

# set maintainer
LABEL maintainer "me@buluma.me.ke"
LABEL build_date="2022-05-22"

# Install requirements.
RUN yum -y install rpm centos-release dnf-plugins-core \
 && yum -y update \
 && yum -y config-manager --set-enabled powertools \
 && yum -y install \
      epel-release \
      initscripts \
      sudo \
      which \
      hostname \
      libyaml-devel \
      python3 \
      python3-pip \
      python3-pyyaml \
 && yum clean all

ADD requirements.txt /requirements.txt
RUN python -m pip install -r /requirements.txt

# set a health check
HEALTHCHECK --interval=5s \
            --timeout=5s \
            CMD curl -f http://127.0.0.1:8000 || exit 1

#EXPOSE 80
EXPOSE 8000
