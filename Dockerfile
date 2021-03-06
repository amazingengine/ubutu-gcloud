FROM ubuntu:18.04

RUN apt update && apt install curl python2.7 wget gnupg -y

# cloud-sdk-bionicのbionic部分はディストリビューションのコードネームです。もしimageを変える場合は変更してください。
# lsb_release -c -sを使うよう公式には言われてますけど、ubuntu:18.04IMAGEではうまく行かなかったです。
RUN export CLOUD_SDK_REPO="cloud-sdk-bionic" && \
    echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt update -y && apt install google-cloud-sdk kubectl -y

COPY ./copy/helm-v2.10.0-linux-amd64.tar.gz /copy/helm-v2.10.0-linux-amd64.tar.gz

RUN tar -zxvf /copy/helm-v2.10.0-linux-amd64.tar.gz

RUN mv linux-amd64/helm /usr/local/bin/helm
