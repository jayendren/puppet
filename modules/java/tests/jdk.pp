#
# Java JDK installation to /usr
#
class { 'java':
  distribution => 'jdk',
  src_url      => 'http://download.oracle.com/otn-pub/java/jdk/7u25-b15/jdk-7u25-linux-x64.tar.gz',
  dst_dir      => '/usr',
  install_log  => '/root/java_installation.log',  
}