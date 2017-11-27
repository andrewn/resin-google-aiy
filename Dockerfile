FROM resin/raspberrypi3-debian:stretch

# Adds the Raspberry Pi foundation's package repo
RUN curl -sL http://archive.raspberrypi.org/debian/raspberrypi.gpg.key | apt-key add -
RUN echo "deb http://archive.raspberrypi.org/debian stretch main" > /etc/apt/sources.list.d/pi.list

RUN curl -sL https://github.com/google/aiyprojects-raspbian/archive/voicekit.tar.gz | tar xz --directory /usr/

RUN apt-get update
RUN /usr/aiyprojects-raspbian-voicekit/scripts/install-deps.sh
RUN /usr/aiyprojects-raspbian-voicekit/scripts/install-services.sh

COPY assistant.json /root/assistant.json
COPY asound.conf /etc/asound.conf

WORKDIR /usr/app
COPY ./start.sh /usr/app/start.sh

ENV INITSYSTEM on

# The first time you push the container uncomment this line
# When you ssh into the container, you can run bash start.sh
# to start the verification process
# CMD ["bash"]

# Once you've successfully entered your credentials then
# you can uncomment this line and do another push.
# The container will then always boot straight into the
# google demo app
CMD ["bash", "start.sh"]
