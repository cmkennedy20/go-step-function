FROM localstack/localstack
RUN mkdir -p /opt/localstack_home/
RUN apt-get update -y