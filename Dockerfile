FROM alpine:3.5
ADD packages.R packages.R
ADD r.conf /etc/apache2/conf.d/r.conf
RUN apk add --update apache2 apache2-dev R-dev R openssl g++ git bash && \
    wget https://github.com/jeffreyhorner/rapache/archive/v1.2.8.tar.gz && \
    tar xzvf v1.2.8.tar.gz && \
    cd rapache-1.2.8 && \
    ./configure && make && make install && \
    mkdir /run/apache2/ && \
    cd .. && Rscript packages.R && \
    apk del bash git g++ R-dev apache2-dev make && \
    rm v1.2.8.tar.gz
CMD ["httpd", "-D", "FOREGROUND"]
