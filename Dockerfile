from fedora:latest
RUN dnf clean all
RUN dnf -y update && dnf -y install openssh-server passwd
RUN dnf -y groupinstall "MATE Desktop"
RUN dnf -y install x2goserver
RUN dnf clean all
COPY src/entrypoint.sh /entrypoint.sh

EXPOSE 22

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D"]