from fedora:latest
RUN dnf clean all && dnf -y update \
 && dnf -y install openssh-server \ 
  passwd \
  docker-client \
  nano \
  git \
  sipcalc \
 && dnf -y groupinstall "MATE Desktop" \
 && dnf -y install x2goserver \
 && dnf clean all
COPY src/entrypoint.sh /entrypoint.sh

EXPOSE 22

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D"]
