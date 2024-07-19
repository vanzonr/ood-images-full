#!/bin/bash
# file: centos7_base_setup.sh
#
# Installs yum and python packages not in the generic/centos7 base
#
# Ramses van Zon, Jul 2024
#

# correct base repo
sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*


# add epel repository
newrepo='https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm'
repofile=$(basename $newrepo)
reponame=${repofile%%-*}
if ! yum repolist | grep -q "^$reponame/"
then
    curl -O "$newrepo"
    rpm -ivh "$repofile"
fi

yum --assumeyes install python3 

if false; then
# install shells
yum --assumeyes install 'bash' 'ksh' 'tcsh' 'zsh' 'deltarpm' 

# install editors
yum --assumeyes install 'vim-enhanced' 'emacs' 'nano' 'nedit' 'emacs-filesystem'

# install x11 stuff (for X forwarding)
yum --assumeyes install 'xauth' 'xorg-x11-apps' 'xterm' 

# install compression software
yum --assumeyes install 'pigz' 'gzip' 'tar' 'dar' 'bzip2' 'bzip2-devel' 'xz' 'zip'

# install development environment
yum --assumeyes install 'apr' 'apr-util' 'avahi-libs' 'boost-date-time' 'boost-system'
yum --assumeyes install 'boost-thread' 'cpp','dwz' 'dyninst' 'efivar-libs'
yum --assumeyes install 'elfutils-default-yama-scope','gdb'
yum --assumeyes install 'gettext-common-devel' 'gettext-devel' 'glibc-devel'
yum --assumeyes install 'glibc-headers' 'kernel-debug-devel' 'kernel-headers' 'libdwarf'
yum --assumeyes install 'libgfortran' 'libgnome-keyring' 'libquadmath'
yum --assumeyes install 'libquadmath-devel' 'libstdc++-devel' 'mokutil' 'neon'
yum --assumeyes install 'pakchois' 'perl-Data-Dumper' 'perl-Error' 'perl-Git'
yum --assumeyes install 'perl-TermReadKey' 'perl-Test-Harness' 'perl-Thread-Queue'
yum --assumeyes install 'perl-XML-Parser' 'perl-srpm-macros' 'rsync' 'subversion-libs'
yum --assumeyes install 'systemtap-client' 'systemtap-devel' 'systemtap-runtime'
yum --assumeyes install 'unzip' 'zip' 'gcc-c++' 'autoconf' 'automake' 'make' 

# install further development environment for lmod
yum --assumeyes install 'lua' 'lua-devel' 'lua-posix' 'lua-filesystem'
yum --assumeyes install 'python2-pip' 'tcl' 'tcl-devel' 'patch' 'mlocate'

# install even more development packages
yum --assumeyes install 'ncurses-devel','libibverbs-dev' 'libibverbs-devel' 'rdma-core-devel'

# install more utilities
yum --assumeyes install 'screen' 'bc' 'less' 'diffutils' 'gawk' 'sed' 'file' 'findutils' 'dos2unix' 'git' 'git-all' 'gitk' 'git-annex' 

# install more utilities
##yum --assumeyes install 'openssl-devel' 'libssl-dev' 'libopenssl-devel'

# install package that on Cedar and Graham are in Nix
##yum --assumeyes install 'alsa-lib'  'alsa-lib-devel'  'asciidoc'  'asciidoc-latex' 
##yum --assumeyes install 'bzr' 'finger'  
##yum --assumeyes install 'cairo' 'cairo-devel' 'colordiff' 'coreutils' 'cpio' 
##yum --assumeyes install 'curl' 'libcurl' 'libcurl-devel' 'cyrus-sasl' 'cyrus-sasl-devel' 
##yum --assumeyes install 'ed' 'elinks' 'expat' 'expat-devel' 'expect' 'expect-devel' 
##yum --assumeyes install 'fltk' 'fltk-devel'
##yum --assumeyes install 'fontconfig' 'fontconfig-devel' 'freetype' 'freetype-devel' 
##yum --assumeyes install 'gd' 'gd-devel' 'gdbm-devel' 'gdk-pixbuf2' 'gdk-pixbuf2-devel' 'gettext' 'gettext-devel' 'ghostscript' 
##yum --assumeyes install 'glew' 'glew-devel' 
##yum --assumeyes install 'glib' 'glib-devel' 'glibc-common' 'glibc-static' 'glibc-devel' 
##yum --assumeyes install 'glx-utils'
##yum --assumeyes install 'grep' 'sed' 'gnutls' 'gnutls-utils' 'gperf' 
##yum --assumeyes install 'GraphicsMagick' 'GraphicsMagick-devel' 'GraphicsMagick-c++-devel' 
##yum --assumeyes install 'graphviz' 'graphviz-lua' 'graphviz-python' 'graphviz-ruby' 'graphviz-tcl' 'graphviz-devel' 
##yum --assumeyes install 'gstreamer' 'gstreamer-devel' 
##yum --assumeyes install 'gtk+' 'gtk+-devel' 
##yum --assumeyes install 'jasper' 'jasper-devel' 'jasper-libs' 
##yum --assumeyes install 'libarchive' 'libarchive-devel' 
##yum --assumeyes install 'libfabric' 'libfabric-devel' 
##yum --assumeyes install 'libibverbs' 'libibverbs-utils' 
##yum --assumeyes install 'libjpeg-turbo' 'libjpeg-turbo-utils' 
##yum --assumeyes install 'libjpeg-turbo-devel' 'libjpeg-turbo-static' 
##yum --assumeyes install 'krb5-libs' 'krb5-devel' 
##yum --assumeyes install 'libnl' 'libnl-devel' 
##yum --assumeyes install 'libpng' 'libpng-devel' 'libpng-static' 
##yum --assumeyes install 'librdmacm' 
##yum --assumeyes install 'libtiff' 'libtiff-devel' 
##yum --assumeyes install 'libxml2' 
##yum --assumeyes install 'libxml2-devel' 
##yum --assumeyes install 'libXpm' 'libXpm-devel' 
##yum --assumeyes install 'libxslt' 
##yum --assumeyes install 'libxslt-devel' 
##yum --assumeyes install 'pam' 'pam-devel' 
##yum --assumeyes install 'lmdb' 'lmdb-devel' 
##yum --assumeyes install 'redhat-lsb' 
##yum --assumeyes install 'lz4' 'lz4-devel' 'lz4-static' 
##yum --assumeyes install 'imake' 
##yum --assumeyes install 'man-db' 
##yum --assumeyes install 'mercurial' 
##yum --assumeyes install 'motif' 'motif-devel' 
##yum --assumeyes install 'munge' 'munge-devel' 
##yum --assumeyes install 'ncurses' 'ncurses-devel' 'ncurses-static' 
##yum --assumeyes install 'net-tools' 
##yum --assumeyes install 'ocaml' 'ocaml-opam-file-format' 
##yum --assumeyes install 'openssl' 'openssl-libs' 'openssl-devel' 'openssl-static' 
##yum --assumeyes install 'pango' 'pango-devel' 
##yum --assumeyes install 'pciutils' 'pciutils-devel' 
##yum --assumeyes install 'pcre2' 'pcre' 'pcre-devel' 'pcre-static' 
##yum --assumeyes install 'perl' 'perl-DBI' 'perl-Log-Log4perl' 'perl-Module-Build' 
##yum --assumeyes install 'pkgconfig' 
##yum --assumeyes install 'procps-ng' 'procps-ng-devel' 'procps-ng-i18n' 
##yum --assumeyes install 'psmisc' 
##yum --assumeyes install 'python' 'python2-pip' 'python-setuptools' 'python-virtualenv' 
##yum --assumeyes install 'qt5-qtbase' 'qt5-qtdeclarative' 'qt5-qttools' 'qt5-qttools-devel' 'qt5-qtxmlpatterns' 
##yum --assumeyes install 'rsync' 'screen' 'fuse-sshfs' 'strace' 'systemtap' 
##yum --assumeyes install 'tcl' 'telnet' 'texinfo' 'tigervnc' 'time' 'tk' 'tkinter' 
##yum --assumeyes install 'tmux' 'traceroute' 'tree' 
##yum --assumeyes install 'unzip' 'util-linux' 'VirtualGL' 'wget' 'which' 
##yum --assumeyes install 'xorg-x11-apps' 'xorg-x11-server-utils' 'xterm' 'xorg-x11-server-Xvfb' 
##yum --assumeyes install 'yasm' 'zeromq' 

#twm -> find rh6 rpm

# for ldap (I think)
###yum --assumeyes install 'openldap' 'openldap-clients' 'perl-LDAP' 'python-ldap' 'nss-pam-ldapd' 

# for slurm
##yum --assumeyes install 'munge' 'munge-devel' 'munge-libs'

# python packages
pip install --upgrade pip
pip install 'docopt'

fi

# post process
updatedb
