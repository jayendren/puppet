#
# Java JRE installation to /usr
#
class { 'java':
  distribution => 'jre',
  src_url      => 'http://download.oracle.com/otn-pub/java/jdk/7u25-b15/jre-7u25-linux-x64.tar.gz',
  dst_dir      => '/usr',
  install_log  => '/root/java_installation.log',    
}
