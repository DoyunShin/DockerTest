FROM rockylinux:9.1.20230215

RUN echo "mirror.ontdb.com 10.254.254.1" > /etc/hosts
RUN curl https://bootstrap.pypa.io/get-pip.py | python3
RUN sed -i "s/#baseurl/baseurl/g" /etc/yum.repos.d/rocky-* && sed -i "s/mirrorlist/#mirrorlist/g" /etc/yum.repos.d/rocky-* && sed -i "s/dl.rockylinux.org/mirror.ontdb.com/g" /etc/yum.repos.d/rocky-*
RUN dnf update -y && dnf groupinstall -y "Development Tools" -x jna -x java-11-openjdk-headless
RUN dnf install epel-release -y
RUN /usr/bin/crb enable && sed -i 's/#baseurl/baseurl/g' /etc/yum.repos.d/epel* && sed -i 's/metalink/#metalink/g' /etc/yum.repos.d/epel* && sed -i 's/download.example/mirror.ontdb.com/g' /etc/yum.repos.d/epel*
RUN dnf install sudo htop screen -y
RUN dnf clean all

RUN useradd -m coder && echo "coder ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/nopasswd
USER coder