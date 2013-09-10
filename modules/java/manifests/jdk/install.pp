# = Class: java::jdk::install
#
#   - This class installs oracle jdk using a source .tar.gz from 
#    - http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html
#
# == Parameters:
#
#   - src          => url to .tar.gz file
#   - dst          => tarball will be extracted to this directory (must be fully qualified)
#   - exec_timeout => optional timeout for installation (default 1200sec)
#   - logfile      => optional install log file, (default /root/java_installation.log)
#
# == Actions:
#
#   - Ensures wget package is installed,
#   - Deploys java installer script from:
#    - modules/java/templates/scripts/java_install.sh.erb to /root
#    - executes /root/java_install.sh -jdk
#     - script extracts tarball to $dst, and 
#      - symlinks $dst/jdkdir/bin/java /usr/bin/java
#      - fails if existing java is detected
#
# == Requires:
#
#   - file { '/root/java_install.sh': require  => package { 'wget'}, before   => Exec ['jdk_install'],
#
# == Sample Usage:
# 
#   - class { 'java::jdk::install':
#       src => 'http://download.oracle.com/otn-pub/java/jdk/7u25-b15/jdk-7u25-linux-x64.tar.gz',
#       dst => '/usr',
#     }
#
# === Authors
#
#   - Jayendren Maduray <jayendren@gmail.com>
#
#
class java::jdk::install(
  $src,
  $dst,
  $exec_timeout = "1200",
  $logfile      = "/root/java_installation.log"
) {  
  if ($src == "") or ($dst == "") { fail "src or dst cannot be empty!" }
  elsif !($src =~ /\.tar\.gz/) { fail "src must be in .tar.gz format!" }

  case $::operatingsystem {
  	Default: { fail "$::operatingsystem is not supported" }

    Ubuntu,RedHat,CentOS: {
      package { 'wget':
        ensure   => installed,
      }       

      info "$::fqdn initated java::jre::install local log => $logfile"
      file { '/root/java_install.sh':
        replace  => true,
        owner    => '0',
        group    => '0',
        mode     => '0555',
        content  => template('java/scripts/java_install.sh.erb'),
        before   => Exec ['jdk_install'],
        require  => Package ['wget'],
      }

      $jdk_puppet_log      = "/root/Puppet_Java_JDK.log"
      $jdk_install_success = "grep success $jdk_puppet_log"
      exec { 'jdk_install':
        command  => "bash /root/java_install.sh > $jdk_puppet_log",
        path     => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
        unless   => $jdk_install_success,
        timeout  => $exec_timeout,
      }

    }

  }
}
