# Set the base image to Ubuntu
FROM ubuntu:18.04
MAINTAINER Sara Movahedi movahedisara@yahoo.com

# Update the repository sources list
#RUN apt-add-repository multiverse
RUN apt-get update
RUN apt-get install -y -q software-properties-common

# Install compiler and perl stuff
RUN apt-get install -y -q libboost-iostreams-dev libboost-system-dev libboost-filesystem-dev
RUN apt-get install -y -q zlibc gcc-multilib apt-utils zlib1g-dev 									# python python-pip
RUN apt-get install -y -q libx11-dev libxpm-dev libxft-dev libxext-dev libncurses5-dev
RUN apt-get install -y -q cmake tcsh build-essential g++ git wget gzip perl unzip
RUN add-apt-repository -y ppa:webupd8team/java    
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get update 
RUN apt-get install -y -q oracle-java8-installer
RUN apt-get install -y -q oracle-java8-set-default 
RUN apt-get install -y -q openjdk-8-jdk openjdk-8-jre

ENV JAVA_HOME=/usr/lib/jvm/java-8-oracle
ENV CLASSPATH=/usr/lib/jvm/java-8-oracle/bin

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 314DF160
RUN add-apt-repository 'deb http://ppa.launchpad.net/ubuntugis/ubuntugis-unstable/ubuntu bionic main '
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install -y r-base
RUN R --version

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y -q vim samtools
RUN apt-get install -y -q tophat

# MySQL
RUN apt-get -y update 
RUN apt-get -y install mysql-client 

# CPAN
RUN apt-get install -y bioperl
RUN perl -MCPAN -e 'install Bio::SeqIO'
RUN perl -MCPAN -e 'install Bio::DB::GenBank'
RUN perl -MCPAN -e 'install Bio::DB::Failover'
RUN perl -MCPAN -e 'install Bio::DB::RefSeq'
RUN perl -MCPAN -e 'install Bio::DB::SoapEUtilities::Result'
RUN perl -MCPAN -e 'install DBD::mysql'
WORKDIR /
RUN mkdir modules && \ 
 cd modules && \ 
 wget http://search.cpan.org/CPAN/authors/id/C/CJ/CJFIELDS/Bio-EUtilities-1.72.tar.gz && \
 tar -xvzf Bio-EUtilities-1.72.tar.gz && cd Bio-EUtilities-1.72 && perl Build.PL && ./Build && \
 perl -MCPAN -e 'force install Bio::DB::EUtilities'

RUN apt -y update 
RUN apt -y upgrade
RUN apt -y clean
