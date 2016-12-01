#!/bin/bash

: ${X2GO_USERNAME:=x2go}
: ${X2GO_USERPASS:=$(dd if=/dev/urandom bs=1 count=15 | base64)}

__create_rundir() {
    mkdir -p /var/run/sshd
    chmod 1777 /dev/shm
}

__create_user() {
# Create a user to SSH into for X2GO.
useradd $X2GO_USERNAME
echo -e "$X2GO_USERPASS\n$X2GO_USERPASS" | (passwd --stdin $X2GO_USERNAME)
echo X2GO user password: $X2GO_USERPASS
usermod -a -G x2gouser $X2GO_USERNAME
usermod -a -G wheel $X2GO_USERNAME
}

__setup_ssh() {
ssh-keygen -A -N ''    
rm -f /run/nologin
}

# Call all functions
__create_rundir
__setup_ssh
__create_user

exec "$@"