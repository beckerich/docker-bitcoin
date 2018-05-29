FROM debian:stretch-slim

# Get Dependencies
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y --no-install-recommends apt-utils 
RUN apt-get -y install \
	libssl libboost libevent libdb4.8 \

# Build
RUN git clone https://github.com/bitcoin/bitcoin.git --branch v0.16.0 /tmp/coin-daemon
WORKDIR /tmp/coin-daemon
RUN ./autogen.sh
RUN ./configure
RUN make
RUN make install

RUN mkdir -p /coin/data

WORKDIR /coin
RUN cp /tmp/coin-daemon/src/bitcoind ./daemon
RUN cp /tmp/coin-daemon/src/bitcoin-cli ./cli

EXPOSE 3000
EXPOSE 3001
CMD ./daemon --datadir=/coin/data
