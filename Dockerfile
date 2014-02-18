FROM ubuntu:12.04

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y curl rubygems

RUN curl -L https://go.googlecode.com/files/go1.2.linux-amd64.tar.gz | tar xzf -

RUN gem install chef-zero

ENV GOPATH /
ENV GOROOT /go
ENV PATH $PATH:/go/bin

ADD .test-knife.rb /.chef/knife.rb
ADD . /src/github.com/marpaia/chef-golang
WORKDIR /src/github.com/marpaia/chef-golang

RUN sh -c "chef-zero & go test -v -cover"

