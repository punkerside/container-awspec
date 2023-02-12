FROM alpine:3.17.1

RUN apk update && apk upgrade && apk add --no-cache \
  curl \
  unzip \
  ruby \
  ruby-dev \
  build-base \
  bash \
  aws-cli \
  jq \
  gettext

# instalando terraform
RUN curl -s https://releases.hashicorp.com/terraform/1.3.7/terraform_1.3.7_linux_amd64.zip -o /tmp/terraform_1.3.7_linux_amd64.zip && \
  unzip /tmp/terraform_1.3.7_linux_amd64.zip -d /tmp/ && \
  chmod +x /tmp/terraform && mv /tmp/terraform /usr/bin/ && \
  rm -rf /tmp/terraform_1.3.7_linux_amd64.zip

# ENV GEM_HOME=/home/.gem
# ENV GEM_PATH=/home/.gem

RUN gem install bundler

RUN gem install aws-sdk && \
  gem install awspec && \
  gem install kitchen-terraform && \
  gem install kitchen-verifier-awspec



# COPY Gemfile /Gemfile
# RUN gem install bundler:2.4.6 && \
#   ${GEM_HOME}/gems/bundler-2.4.6/exe/bundle install --jobs 4 --retry 3 --system

# RUN gem install bundler:2.2.33 && \
#   ${GEM_HOME}/gems/bundler-2.2.33/exe/bundle install --jobs 4 --retry 3 --system


# # fix
# RUN chmod -R 777 /usr/lib/ruby/ && chmod -R 777 /usr/bin

# # configurando entorno
# WORKDIR /app
# ENV TF_CLI_CONFIG_FILE=/home/terraformrc
# COPY init.sh /usr/bin/init.sh
# ENTRYPOINT [ "/usr/bin/init.sh" ]

# configurando entorno
WORKDIR /app
CMD [ "bundle", "exec", "kitchen", "test" ]