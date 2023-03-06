FROM ubuntu:22.04

# configurando entorno
ENV DEBIAN_FRONTEND noninteractive

# instalando paquetes
RUN apt-get update && apt-get -y upgrade && apt-get install -y build-essential && apt-get install -y ruby ruby-dev curl git

# instalando terraform
RUN curl -s https://releases.hashicorp.com/terraform/1.3.9/terraform_1.3.9_linux_amd64.zip -o /tmp/terraform_1.3.9_linux_amd64.zip && \
  unzip /tmp/terraform_1.3.9_linux_amd64.zip -d /tmp/ && \
  chmod +x /tmp/terraform && mv /tmp/terraform /usr/bin/ && \
  rm -rf /tmp/terraform_1.3.9_linux_amd64.zip

# configurando ruby
ENV GEM_HOME /home/.gem
ENV GEM_PATH /home/.gem

# instalando gemas
RUN gem install bundler:2.4.7 && \
  gem install --no-user-install aws-sdk && \
  gem install --no-user-install awspec && \
  gem install --no-user-install kitchen-terraform && \
  gem install --no-user-install kitchen-verifier-awspec

# configurando entorno
WORKDIR /app
CMD [ "/home/.gem/gems/bundler-2.4.7/exe/bundle", "exec", "kitchen", "test" ]