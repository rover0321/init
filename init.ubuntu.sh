#!/bin/bash
set -o nounset
set -o errexit
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

    if [ -f .vimrc ];then
        echo 'Back up old .vimrc file.'
        mv .vimrc .vimrc.ori
    fi
    ln -s ini/vimrc .vimrc
fi

# begin download maven tomcat jdk
# switch to sft
cd ~/sft

# download and config maven
read -p "Would you like download maven for you? y/n " cmd
if [ $cmd == 'y' ];then
    wget https://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz
    tar -xzvf apache-maven-3.5.4-bin.tar.gz
    ln -s ~/sft/apache-maven-3.5.4 ~/ins/mvn
fi

read -p "Would you like config settings.xml for you? y/n " cmd
if [ $cmd == 'y' ]; then
    if [ -f ~/ins/mvn/conf/settings.xml ];then
        rm -f ~/ins/mvn/conf/settings.xml
    fi
    ln -s ~/ini/settings.xml ~/ins/mvn/conf/settings.xml
fi

# install openjdk and source code.
read -p "Would you like download openjdk-8-jdk and openjdk-8-source for you? y/n " cmd
if [ $cmd == 'y' ];then
    sudo apt-get install openjdk-8-jdk && sudo apt-get install openjdk-8-source
    ln -s /usr/lib/jvm/java-8-openjdk-amd64 ~/ins/jdk
fi

# download and config tomcat
read -p "Would you like download tomcat for you? y/n " cmd
if [ $cmd == 'y' ];then
	# 此处需求解析一下网页内容，获取最新的tomcat版本，然后动态生成链接。
    wget https://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-8/v8.5.38/bin/apache-tomcat-8.5.38.tar.gz
    tar -xzvf apache-tomcat-8.5.38.tar.gz
    if [ -f ~/ins/tmc ]; then
        rm -rf ~/ins/tmc
    fi
    ln -s ~/sft/apache-tomcat-8.5.38 ~/ins/tmc
fi

read -p "Would you like install cmake? y/n " cmd
if [ $cmd == 'y' ]; then
    sudo apt-get install cmake
fi

read -p "Would you like install gdb? y/n " cmd
if [ $cmd == 'y' ]; then
    sudo apt-get install gdb
fi

read -p "Would you like install pip3? y/n " cmd
if [ $cmd == 'y' ]; then
    sudo apt-get install python3-pip
fi

# Switch to user home directory.
cd ~

#init git config
read -p "Would you like to config git? y/n " cmd
if [ $cmd == 'y' ];then
    ln -s ~/ini/gitconfig ~/.gitconfig
fi

# config .gitconfig file
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

read -p "Would you like install build-essential for you? y/n " cmd
if [ $cmd == 'y' ]; then
    sudo apt-get install build-essential
fi


read -p "Would you like install docker-ce for you? y/n " cmd
if [ $cmd == 'y' ]; then
    sudo apt-get install docker-ce
fi

read -p "Would you like install python-software-properties? y/n " cmd
if [ $cmd == 'y' ]; then
    sudo apt-get install python-software-properties
    sudo apt-get update
    sudo apt install software-properties-common
    sudo apt-get update
fi
read -p "Would you like install transmission-cli which is quitely convenient for download bt? y/n " cmd
if [ $cmd == 'y' ]; then
    sudo apt-get install transmission-cli
fi
echo 'Exit init.sh script.'
