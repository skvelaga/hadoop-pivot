### Steps to install hadoop-pivot tracing on AWS ###
## Pre-reqs
sudo -s


## X11 Forwarding
apt-get -y update
apt-get -y dist-upgrade
apt-get -y install xfce4
sed -i  's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config
apt-get -y install firefox gedit

## JAVA
add-apt-repository ppa:webupd8team/java # press enter
apt-get -y update
# Oracle JAVA 8 License installation #
$ echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
apt-get -y install oracle-java8-installer
update-java-alternatives -s java-8-oracle
export JAVA_HOME=/usr/lib/jvm/java-8-oracle

## Maven
wget http://apache.mirror.anlx.net/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
wget http://apache.mirror.anlx.net/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
tar -zxf apache-maven-3.3.9-bin.tar.gz
cp -R apache-maven-3.3.9 /usr/local
ln -s /usr/local/apache-maven-3.3.9/bin/mvn /usr/bin/mvn
ln -s /usr/local/apache-maven-3.3.9/bin/mvnDebug /usr/bin/mvnDebug
#mvn -version
apt-get -y install make
apt-get -y install gcc
apt-get -y install g++

## Protobuf
apt-get -y install protobuf-compiler
curl -# -O https://protobuf.googlecode.com/files/protobuf-2.5.0.tar.gz
gunzip protobuf-2.5.0.tar.gz
tar -xvf protobuf-2.5.0.tar
cd protobuf-2.5.0
./configure
make ;make install
cd ..

## AspectJ 
#wget 'ftp://ftp.stu.edu.tw/eclipse/tools/aspectj/aspectj-1.8.9.jar'
#java -jar aspectj-1.8.9.jar 
#how to bypass next->next->finish command

## ANT install
apt-get -y install ant

## Environment Variables
export CLASSPATH=/root/aspectj1.8/lib/aspectjrt.jar 
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root/aspectj1.8/bin

## Tracing Framework
apt-get -y install git
git clone https://github.com/brownsys/tracing-framework
cd tracing-framework/
mvn clean package install -DskipTests
cd ..

## Pivot Tracing with Hadoop
git clone https://github.com/brownsys/hadoop
cd hadoop/
mvn clean package install -Pdist -DskipTests -Dmaven.javadoc.skip="true"
ls hadoop-dist/target/hadoop-2.7.2/

## Environment Variables
cd hadoop-dist/target/hadoop-2.7.2/
export HADOOP_HOME=`pwd`

mkdir ~/config
cp -R etc/hadoop ~/config/
cd ~/config/hadoop/
export HADOOP_CONF_DIR=`pwd`