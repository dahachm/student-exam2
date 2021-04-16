FROM alpine:3.12

RUN apk add \
    openjdk8 \
    openssh \
    openrc \
    python3 \
    py3-pip \
    ansible \
    git

RUN adduser -D jenkins

RUN mkdir /home/jenkins/.ssh \
    && touch /home/jenkins/.ssh/authorized_keys \
    && chown -R jenkins /home/jenkins/.ssh \
    && chmod 700 /home/jenkins/.ssh \
    && chmod 600 /home/jenkins/.ssh/authorized_keys

VOLUME ~/jenkins_home_agent:/var/jenkins_home

RUN rc-update add sshd 

ENV SSH_PUBLIC_KEY ''

COPY scripts/setup-ssh.sh /usr/local/setup-ssh.sh

CMD /bin/sh /usr/local/setup-ssh.sh && tail -f /dev/null
