FROM hashicorp/terraform:latest
RUN apk update \
    && apk add --no-cache bash curl unzip zip
ENV TF_HOME /opt/tf_home/ 
RUN mkdir -p ${TF_HOME}
WORKDIR ${TF_HOME}
# Install aws-cli & python3 for tf-local tool
RUN apk add --no-cache aws-cli python3 py3-pip
# Install the tf-local cli
RUN pip install terraform-local