#!/bin/bash
read -p "Would you like to update this system? y/n " cmd
if [ $cmd == 'y' ];then
    sudo apt-get update
fi

read -p "Would you like to install openssh-server and openssh-client for you? y/n " cmd
if [ $cmd == 'y' ];then 
    sudo apt-get install openssh-server openssh-client
fi

#init dirs
echo 'init dirs'
cd
if [ ! -d ~/wks ];then
    mkdir wks
fi

if [ ! -d ~/ins ];then
    mkdir ins
fi

if [ ! -d ~/sft ];then
    mkdir sft
fi

#init git config
read -p "Would you like to config git? y/n " cmd
if [ $cmd == 'y' ];then
    git config --global user.email "rover0321@qq.com"
    git config --global user.name "huangxiang"
    git config --global core.editor vim
fi

read -p "Would you like to clone ini from github? y/n " cmd
if [ $cmd == 'y' ];then
    echo 'git clone https://github.com/rover0321/ini.git'
    git clone https://github.com/rover0321/ini.git
fi

read -p "Would you like clone utility commonds from github? y/n " cmd
if [ $cmd == 'y' ];then
    echo 'git clone https://github.com/rover0321/bin.git'
    git clone https://github.com/rover0321/bin.git
fi

# begin download maven tomcat jdk
# switch to sft
cd ~/sft

# download and config maven
read -p "Would you like download maven for you? y/n " cmd
if [ $cmd == 'y' ];then
    echo 'wget http://mirror.bit.edu.cn/apache/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.tar.gz'
    wget http://mirror.bit.edu.cn/apache/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.tar.gz
    tar -xzvf apache-maven-3.5.0-bin.tar.gz
    ln -s ~/sft/apache-maven-3.5.0 ~/ins/mvn
fi

# download and config jdk
read -p "Would you like download jdk for you? y/n " cmd
if [ $cmd == 'y' ];then
    wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz
    tar -xzvf jdk-8u131-linux-x64.tar.gz
    ln -s ~/sft/jdk1.8.0_131 ~/ins/jdk
fi

# download and config tomcat
read -p "Would you like download tomcat for you? y/n " cmd
if [ $cmd == 'y' ];then
    wget http://mirror.bit.edu.cn/apache/tomcat/tomcat-8/v8.5.23/bin/apache-tomcat-8.5.23.tar.gz
    tar -xzvf apache-tomcat-8.5.16.tar.gz
    ln -s ~/sft/apache-tomcat-8.5.16 ~/ins/tmc
fi

# back to home directory
cd ~

read -p "Would you like config .bashrc and .profile for you? y/n " cmd
if [ $cmd == 'y' ]; then
    os=`uname`
    if [ -f .bashrc ];then
        echo 'back up old .bashrc file.'
        mv .bashrc .bashrc.ori
    fi
    if [ $os == 'Darwin' ];then
        ln -s .bashrc .bash_profile
    else
        ln -s ini/bashrc .bashrc
    fi

    if [ -f .profile ];then
        echo 'back up old .profile file.'
        mv .profile .profile.ori
    fi
    ln -s ini/profile .profile

    if [ -f .vimrc ];then
        echo 'Back up old .vimrc file.'
        mv .vimrc .vimrc.ori
    fi
    ln -s ini/vimrc .vimrc
fi

read -p "Would you like config .gitignore for you? y/n " cmd
if [ $cmd == 'y' ]; then
    if [ -f .gitignore ];then
        read -p "Would you like to add custom .gitignore file? y/n " cmd
        if [ $cmd == 'y' ];then
            echo 'back up old .gitignore file.'
            mv .gitignore .gitignore.ori
            ln -s ini/gitignore .gitignore
        fi
    fi
fi
echo 'Launch new .bashrc file.'
source .bashrc

echo 'Exit init.sh script.'
