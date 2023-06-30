FROM ubuntu:22.04

# configurando entorno
ENV DEBIAN_FRONTEND noninteractive

# instalando paquetes
RUN apt-get update && apt-get -y upgrade && apt-get install -y --no-install-recommends \
  ruby=1:3.0~exp1 \
  ruby-dev=1:3.0~exp1 \
  curl=7.81.0-1ubuntu1.10 \
  git=1:2.34.1-1ubuntu1.9 \
  unzip=6.0-26ubuntu3.1 \
  gettext=0.21-4ubuntu4 && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# instalando terraform
RUN curl -s https://releases.hashicorp.com/terraform/1.5.2/terraform_1.5.2_linux_amd64.zip -o /tmp/terraform_1.5.2_linux_amd64.zip && \
  unzip /tmp/terraform_1.5.2_linux_amd64.zip -d /tmp/ && \
  chmod +x /tmp/terraform && mv /tmp/terraform /usr/bin/ && \
  rm -rf /tmp/terraform_1.5.2_linux_amd64.zip

# configurando ruby
ENV GEM_HOME /home/.gem
ENV GEM_PATH /home/.gem

# instalando gemas
RUN gem install bundler:2.4.7 && \
  gem install --no-user-install aws-sdk:3.1.0 && \
  gem install --no-user-install awspec:1.29.2 && \
  gem install --no-user-install kitchen-terraform:7.0.2 && \
  gem install --no-user-install kitchen-verifier-awspec:0.2.0

# configurando entorno
WORKDIR /app
CMD [ "/home/.gem/gems/bundler-2.4.7/exe/bundle", "exec", "kitchen", "test" ]