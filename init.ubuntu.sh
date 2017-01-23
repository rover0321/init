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
fi

echo 'git clone https://github.com/rover0321/ini.git'
git clone https://github.com/rover0321/ini.git

read -p "Would you like clone utility commonds from github? y/n " cmd
if [ $cmd == 'y' ];then
    echo 'git clone https://github.com/rover0321/bin.git'
    git clone https://github.com/rover0321/bin.git
fi

os=`uname`
if [ -f .bashrc ];then
    echo 'back up old .bashrc file.'
    mv .bashrc .bashrc.ori
    ln -s ini/bashrc .bashrc
    if [ $os == 'Darwin' ];then
       ln -s .bashrc .bash_profile
    fi
fi

if [ -f .profile ];then
    echo 'back up old .profile file.'
    mv .profile .profile.ori
    ln -s ini/profile .profile
fi

if [ -f .vimrc ];then
    echo 'Back up old .vimrc file.'
    mv .vimrc .vimrc.ori
    ln -s ini/vimrc .vimrc
fi

read -p "Would you like to add custom .gitignore file? y/n " cmd
if [ $cmd == 'y' ];then
    echo 'back up old .gitignore file.'
    mv .gitignore .gitignore.ori
    ln -s ini/gitignore .gitignore
fi

echo 'Launch new .bashrc file.'
source .bashrc

echo 'Exit script.'
