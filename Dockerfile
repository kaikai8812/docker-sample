FROM ruby:2.6.3

# 必要なパッケージのインストールを行う
RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs

# 作業ディレクトリを作成する。
RUN mkdir /app_name

#環境変数もAPP_ROOTに、作業ディレクトリを割り当てる。
ENV APP_ROOT /app_name
WORKDIR $APP_ROOT

#ホストファイル内の、Gemfileを、コンテナ側の作業ディレクトリ直下に作成する。
ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

#コンテナ内で、渡したGemfileの内容をbundle installする。
RUN bundle install
ADD . $APP_ROOT
