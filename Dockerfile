FROM ubuntu:latest AS base
COPY b2qt.tz.bz2 /
COPY *.sh /

FROM base AS toolchain
RUN apt-get update && \
	apt-get install -y \
##		gawk \
##		curl \
##		git-core \
##		diffstat \
##		unzip \
##		p7zip \
		gcc-multilib \
		g++-multilib \
		build-essential \
##		chrpath \
##		libsdl1.2-dev \
##		xterm \
##		gperf \
##		bison \
##		texinfo \
		bzip2 \
		&& rm -rf /var/lib/apt/lists/*
RUN mkdir /opt/b2qt && \
	tar -xjvf /b2qt.tz.bz2 -C /opt/b2qt/ || true && \
	rm /b2qt.tz.bz2

FROM toolchain AS builder
ENTRYPOINT ["/compile.sh"]
CMD ["CIM-GUI", "build", "/output"]
