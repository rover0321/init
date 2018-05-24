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

# config bashrc and profile
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
    echo "reload new env profile."
    source .profile

    if [ -f .vimrc ];then
        echo 'Back up old .vimrc file.'
        mv .vimrc .vimrc.ori
    fi
    ln -s ini/vimrc .vimrc
fi

# begin download maven tomcat jdk
# switch to sft
cd ~/sft

line
# download and config maven
read -p "Would you like download maven for you? y/n " cmd
if [ $cmd == 'y' ];then
    wget http://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.5.3/binaries/apache-maven-3.5.3-bin.tar.gz
    tar -xzvf apache-maven-3.5.3-bin.tar.gz
    ln -s ~/sft/apache-maven-3.5.3 ~/ins/mvn
fi

read -p "Would you like config settings.xml for you? y/n " cmd
if [ $cmd == 'y' ]; then
    if [ -f ~/ins/mvn/conf/settings.xml ];then
        rm -f ~/ins/mvn/conf/settings.xml
    fi
    ln -s ~/ini/settings.xml ~/ins/mvn/conf/settings.xml
fi

line
# download and config jdk
read -p "Would you like download jdk for you? y/n " cmd
if [ $cmd == 'y' ];then
    wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/jdk-8u161-linux-x64.tar.gz
    tar -xzvf jdk-8u161-linux-x64.tar.gz
    ln -s ~/sft/jdk1.8.0_161 ~/ins/jdk
fi

line
# download and config tomcat
read -p "Would you like download tomcat for you? y/n " cmd
if [ $cmd == 'y' ];then
    wget http://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-8/v8.5.24/bin/apache-tomcat-8.5.24.tar.gz
    tar -xzvf apache-tomcat-8.5.24.tar.gz
    ln -s ~/sft/apache-tomcat-8.5.24 ~/ins/tmc
fi

line
read -p "Would you like install cmake? y/n " cmd
if [ $cmd == 'y' ]; then
    wget https://cmake.org/files/v3.10/cmake-3.10.3-Linux-x86_64.tar.gz && tar -xzvf cmake-3.10.3-Linux-x86_64.tar.gz && ln -s ~/sft/cmake-3.10.3-Linux-x86_64 ~/ins/cmake
fi

line
read -p "Would you like install gdb? y/n " cmd
if [ $cmd == 'y' ]; then
    sudo apt-get install gdb
fi
# Switch to user home directory.
cd ~

line
#init git config
read -p "Would you like to config git? y/n " cmd
if [ $cmd == 'y' ];then
    ln -s ~/ini/gitconfig ~/.gitconfig
fi

# config .gitconfig file
line
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

echo 'Load new .bashrc file.'
source .bashrc

line
read -p "Would you like install build-essential for you? y/n " cmd
if [ $cmd == 'y' ]; then
    sudo apt-get install build-essential
fi

line
read -p "Would you like install python-software-properties? y/n " cmd
if [ $cmd == 'y' ]; then
    sudo apt-get install python-software-properties
    sudo apt-get update
    sudo apt install software-properties-common
    sudo apt-get update
fi

echo 'Exit init.sh script.'
