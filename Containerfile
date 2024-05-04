FROM fedora-toolbox:40
MAINTAINER Darran Lofthouse darran@lofthouse.me.uk

RUN dnf -y upgrade

RUN dnf -y install openssh-server && \
    printf "Port 2222\nListenAddress localhost\nPermitEmptyPasswords yes\n" >> /etc/ssh/sshd_config \
	&& /usr/libexec/openssh/sshd-keygen rsa \
	&& /usr/libexec/openssh/sshd-keygen ecdsa \
	&& /usr/libexec/openssh/sshd-keygen ed25519

RUN dnf -y group install "C Development Tools and Libraries" "Development Tools" 
RUN dnf -y install \
        tmux \
        mc \
        minicom \
        cmake \
        arm-none-eabi-gcc-cs arm-none-eabi-gcc-cs-c++ \
        arm-none-eabi-newlib \
        libusb1-devel \
        libftdi-devel \
        openocd \
        vim

RUN cd /usr/local/src && \
    mkdir raspberry-pi && \
    cd raspberry-pi && \
    git clone https://github.com/raspberrypi/pico-sdk.git --branch master && \
    cd pico-sdk && \
    git submodule update --init

ENV PICO_SDK_PATH /usr/local/src/raspberry-pi/pico-sdk



