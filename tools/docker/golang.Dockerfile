FROM golang:1.21.3-alpine3.17
ENV go_home /opt/go_home/
RUN mkdir -p ${go_home} 
WORKDIR ${go_home}
