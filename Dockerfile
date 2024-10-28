# ベースイメージとしてUbuntuを使用
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# 必要なパッケージをインストール
RUN apt-get update && apt-get install -y \
    apache2 subversion libapache2-mod-svn \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# SVNリポジトリ用のディレクトリ作成
RUN mkdir -p /var/svn/dev /var/svn/stg \
    && svnadmin create /var/svn/dev \
    && svnadmin create /var/svn/stg

# Apache設定ファイルをコピー
COPY apache-svn.conf /etc/apache2/sites-available/svn.conf

# Apacheモジュールの有効化
RUN a2ensite svn && a2enmod dav && a2enmod dav_svn

EXPOSE 80

# Apacheをフォアグラウンドで起動
CMD ["apache2ctl", "-D", "FOREGROUND"]
