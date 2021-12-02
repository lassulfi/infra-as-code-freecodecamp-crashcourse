FROM node:16-alpine3.14

ENV GLIBC_VER=2.31-r0

RUN apk add --no-cache bash

RUN touch /root/.bashrc | echo "PS1='\w\$ '" >> /root/.bashrc

RUN mkdir -p /home/node/app

RUN apk update && apk upgrade
    
RUN apk --no-cache add \ 
    binutils \
    curl

RUN curl -sL https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub && \
    curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-${GLIBC_VER}.apk && \
    curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-bin-${GLIBC_VER}.apk && \
    curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-i18n-${GLIBC_VER}.apk && \
    apk add --no-cache \
        glibc-${GLIBC_VER}.apk \
        glibc-bin-${GLIBC_VER}.apk \
        glibc-i18n-${GLIBC_VER}.apk && \ 
        /usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    chmod +x aws/install && \
    aws/install
    
RUN curl -fsSL https://get.pulumi.com | sh

RUN export PATH=/.pulumi/bin:$PATH

WORKDIR /home/node/app

USER node

CMD ["tail", "-f", "/dev/null"]