#!/bin/bash

sudo apt-get update
sudo apt-get install openssh-server openssh-client git

#init dirs
cd
mkdir wks
mkdir ins
mkdir sft

#init git config
git config --global user.email "rover0321@qq.com"
git config --global user.name "huangxiang"

echo 'git clone https://github.com/rover0321/ini.git'
echo -n 'yes or no'
read cmd
git clone https://github.com/rover0321/ini.git

echo 'git clone https://github.com/rover0321/bin.git'
echo -n 'yes or no'
read cmd
git clone https://github.com/rover0321/bin.git

mv .bashrc .bashrc.ori
ln -s ini/bashrc .bashrc

mv .profile .profile.ori
ln -s ini/profile .profile

mv .gitconfig .gitconfig.ori
ln -s ini/gitconfig .gitconfig

. .bashrc
