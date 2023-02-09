FROM ubuntu:18.04 as builder
RUN apt-get update && \
	apt-get dist-upgrade -y && \
	apt-get install build-essential git libxcrypt-dev libssl-dev libpcap-dev file patch -y
# TODO: Cache git clone - See https://stackoverflow.com/questions/55003297/how-to-get-git-clone-to-play-nice-with-docker-cache
RUN git clone https://github.com/joswr1ght/asleap && \
	cd asleap && \
	git reset --hard 254acabba34cb44608c9d2dcf7a147553d3d5ba3 && \
	git pull
WORKDIR /asleap
RUN make && \
	strip asleap && \
    strip genkeys
# Do some testing to ensure it works as expected
RUN file asleap | grep dynamically | grep ', stripped' && \
	echo 'abcd1234' | ./asleap -C 53:7a:33:3a:a2:08:38:07 -R 95:e1:4a:5b:6c:0a:18:26:8e:18:7b:da:0b:30:c4:d8:af:d3:38:ad:c5:f3:86:ae -W -

# Stage 2
FROM ubuntu:18.04
LABEL org.opencontainers.image.authors="thomas@finchsec.com"
RUN apt-get update && \
	apt-get dist-upgrade -y && \
	apt-get install libxcrypt1 libssl1.1 libpcap0.8 -y --no-install-recommends && \
	apt-get autoclean && \
	rm -rf /var/lib/dpkg/status-old /var/lib/apt/lists/*
COPY --from=builder /asleap/asleap /usr/bin/asleap
COPY --from=builder /asleap/genkeys /usr/bin/genkeys
# Run test again to ensure the final container works
RUN echo 'abcd1234' | /usr/bin/asleap -C 53:7a:33:3a:a2:08:38:07 -R 95:e1:4a:5b:6c:0a:18:26:8e:18:7b:da:0b:30:c4:d8:af:d3:38:ad:c5:f3:86:ae -W -