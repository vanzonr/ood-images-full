#!/bin/bash
#
# centos7_base_create.sh
#
#
# This script creates a new image using the
# centos7_base_Vagrantfile. which sets up the centos7 base image with
# proper points to active yum repos.
#
# Meant to help the open-on-demand vagrant setup
#
# Ramses van Zon, July 20 2024

function +++() {
    echo "+++" "$@"
}

set -euo pipefail

# Use a subdirectory
here=$PWD

# get the parent box
if ! vagrant box list | grep -q centos7_base; then

    if ! [ -f centos7_base.box ]; then

        +++ creating centos7_base.box +++
        
        # go to a new directory
        mkdir -p ../newbox
        cd ../newbox
        ln -sT $here/centos7_base_setup.sh centos7_base_setup.sh

        # get the parent box
        if ! vagrant box list | grep -q generic/centos7; then
            vagrant box add generic/centos7 --provider virtualbox
        fi

        # start a .vagrant directory
        vagrant init

        # overwrite the Vagrant file and make provisioning scripts available
        \cp -f $here/centos7_base_Vagrantfile Vagrantfile

        # start the box; this'll do all the provisioning
        vagrant up

        # pack it up and move to main directory
        vagrant package --output centos7_base.box
        mv centos7_base.box $here

        # clean up
        vagrant halt
        vagrant destroy -f
        cd $here/..
        [ -d newbox ] && rm -rf newbox
        cd $here

    else
        +++  centos7_base.box found +++
    fi

    +++ registering centos7_base.box with vagrant +++
    cd ..
    vagrant box add centos7_base $here/centos7_base.box
    cd $here
    
else
    +++  centos7_base box already known to vagrant +++
fi

# all done
