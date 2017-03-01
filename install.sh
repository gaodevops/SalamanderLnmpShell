#!/bin/sh

# linux上nginx，php，mysql集成环境
# Author salamander

set -e # "Exit immediately if a simple command exits with a non-zero status."
basepath=$(cd `dirname $0`; pwd)

# 1. nginx安装

yum install -y gcc gcc-c++

tar -zxf nginx-1.10.1.tar.gz 
tar -zxf pcre-8.38.tar.gz
tar -zxf zlib-1.2.11.tar.gz
tar -zxf openssl-1.1.0e.tar.gz



# nginx安装 注意 --with-pcre=  --with-zlib --with-openssl  指的是源码路径
cd ./nginx-1.10.1
./configure --prefix=/usr/local/nginx-1.10.1 --with-pcre=./../pcre-8.38  --with-zlib=./../zlib-1.2.11  --with-openssl=./../openssl-1.1.0e
make
make install


echo 'Nginx installed successfully!'


# 2. php安装
yum -y install libxml2 libxml2-devel openssl openssl-devel curl-devel libjpeg-devel libpng-devel freetype-devel


# 安装libmcrypt库

tar zxvf libmcrypt-2.5.8.tar.gz
cd libmcrypt-2.5.8
./configure
make
make install

cd $basepath

# 安装mhash库

tar zxvf mhash-0.9.9.9.tar.gz
cd mhash-0.9.9.9
./configure
make
make install

cd $basepath

# 安装mcrypt库

tar -zxvf mcrypt-2.6.8.tar.gz
cd mcrypt-2.6.8
export LD_LIBRARY_PATH=/usr/local/lib
./configure
make
make install



cd $basepath

tar -zxvf php-7.0.16.tar.gz
cd ./php-7.0.16


./configure \
 --prefix=/usr/local/php7 \
 --with-config-file-path=/usr/local/php7/etc \
--enable-fpm \
--with-fpm-user=www \
--with-fpm-group=www \
--with-mysqli \
--with-pdo-mysql \
--with-libdir=lib64 \
--with-iconv-dir \
--with-freetype-dir \
--with-jpeg-dir \
 --with-png-dir \
--with-zlib \
--with-libxml-dir=/usr \
--enable-xml \
--disable-rpath  \
--enable-bcmath \
--enable-shmop \
--enable-sysvsem \
--enable-inline-optimization \
--with-curl \
--enable-mbregex \
--enable-mbstring \
--with-mcrypt \
--enable-ftp \
--with-gd \
--enable-gd-native-ttf \
--with-openssl \
--with-mhash \
--enable-pcntl \
 --enable-sockets \
--with-xmlrpc \
--enable-zip \
--enable-soap \
--without-pear \
--with-gettext \
--disable-fileinfo \
--enable-maintainer-zts


echo 'PHP installed successfully!'
