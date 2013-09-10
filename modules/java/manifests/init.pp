# = Class: java
#
#   - This class installs oracle:
#    - jre using a source binary from 
#     - http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html
#    - jdk using a source .tar.gz from 
#     - http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html
#   
#
# == Parameters:
#
#   - distribution => jre or jdk
#   - src_url      => url to binary/tarball
#   - dst_dir      => source will be extracted to this directory (must be fully qualified)
#   - install_log  => optional install log file, (default /root/java_installation.log)
#
# == Sample Usage:
# 
#   - Install JRE: puppet doc modules/java/manifests/jre/install.pp
#    class { 'java':
#      distribution => 'jre',
#      src_url      => 'http://download.oracle.com/otn-pub/java/jdk/7u25-b15/jre-7u25-linux-x64.tar.gz',
#      dst_dir      => '/usr',
#      install_log  => '/root/java_installation.log',
#    }
#
#  - Install JDK: puppet doc modules/java/manifests/jdk/install.pp
#    class { 'java':
#      distribution => 'jdk',
#      src_url      => 'http://download.oracle.com/otn-pub/java/jdk/7u25-b15/jdk-7u25-linux-x64.tar.gz',
#      dst_dir      => '/usr',
#      install_log  => '/root/java_installation.log',
#    }
#
# === Authors
#
#   - Jayendren Maduray <jay.maduray@mtnbusiness.co.za>
#
#
class java(
  $distribution,
  $src_url,
  $dst_dir,
  $install_log = "/root/java_installation.log"
  ) {

  case $distribution {
    jre: {
       $distro = "jre" #used by installer script template
       class { 'java::jre::install':
         src     => $src_url,
         dst     => $dst_dir,
         logfile => $install_log,
       }
    }
    jdk: {
       $distro = "jdk" #used by installer script template      
       class { 'java::jdk::install':
         src     => $src_url,
         dst     => $dst_dir,
         logfile => $install_log,
       }
    }
    '': { fail "supported distributions are jre or jdk" }
  }

}
