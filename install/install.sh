#!/bin/bash

### TODO: move up to main directory and make all source command work


. ./install_functions.sh

INTERACTIVE='yes'

echo "==================== SCOT 3.5 Installer ======================="

if root_check 
then    
    echo "Running as root: Yes"
else
    echo "Running as root: NO (can not proceed)"
    exit 2
fi

if get_http_proxy
then
    echo "http_proxy    : $PROXY"
else
    echo "http_proxy    : not set!"
fi

if get_https_proxy 
then
    echo "https_proxy   : $SPROXY"
else
    echo "https_proxy   : not set!"
fi

set_defaults

if get_script_src_dir
then
    echo "Install Src Dir: $DIR"
else 
    echo "Install Src Dir: unknown (can not proceed)"
    exit 2
fi

if determine_distro
then
    echo "Linux distro   : $DISTRO"
else
    echo "Linux distro   :failed getting distro (can not proceed)"
    exit 2
fi

if get_os_name
then
    echo "Operating Sys  : $OS"
else 
    echo "Operating Sys  : unknown (can not proceed)"
    exit 2
fi

if get_os_version
then
    echo "OS Version     : $OSVERSION"
else
    echo "OS Version     : unknown (can not proceed)"
    exit 2
fi

. ./comandline.sh
default_variables

process_commandline 

show_variables

if [[ $INSTMODE != "SCOTONLY" ]]; then
    . ./install_packages.sh
    install_packages
    . ./install_java.sh
    install_java
    . ./install_activemq.sh
    install_activemq
    . ./install_elasticsearch.sh
    install_elasticsearch
    . ./install_mongodb.sh
    install_mongodb
    . ./install_apache.sh
    install_apache.sh
    . ./install_perl.sh
    install_perl
    configure_filestore
fi

. ./install_scot.sh
install_scot



start_services

if [[ "$AUTHMODE" == "Local"  ]]; then
    echo "!!!!"
    echo "!!!! AUTHMODE is set to LOCAL.  Use the admin username and password"
    echo "!!!! to initially access SCOT.  Please see only documentation for "
    echo "!!!! direction on how to create users/password or to switch "
    echo "!!!! authentication options."
    echo "!!!!"
fi


echo ""
echo "@@"
echo "@@ SCOT online documentaton is available at "
echo "@@  https://localhost/docs/index.html"
echo "@@"
echo ""

echo "----"
echo "----"
echo "---- Install completed"
echo "----"
echo "----"






