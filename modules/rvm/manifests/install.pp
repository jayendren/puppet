# = Class: rvm::install
#
#   - This class installs rvm from github
#    - Supported operatingsystems:
#     - FreeBSD
#
# == Parameters:
#
#   - None
#
# == Actions:
#
#   - Executes:
#   "curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer \
#    -o /root/rvm-installer && chmod +x /root/rvm-installer && \
#    rvm_bin_path=/usr/local/rvm/bin rvm_man_path=/usr/local/rvm/man \
#    /root/rvm-installer && rm /root/rvm-installer'"
#
# == Requires:
#
#   - exec { 'rvm_git_install': require => Package ['ftp/curl'],
#
# == Sample Usage:
# 
#   - include rvm::install
#
# === Authors
#
#   - Jayendren Maduray <jayendren@gmail.com>
#
#
class rvm::install {
	case $::operatingsystem {
		FreeBSD: {
      #package { 'ftp/curl':
      #  ensure   => installed,
      #  provider => portupgrade,
      #}
      exec { 'rvm_git_install':
        command => "curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer \
               -o /root/rvm-installer && chmod +x /root/rvm-installer && \
               rvm_bin_path=/usr/local/rvm/bin rvm_man_path=/usr/local/rvm/man \
               /root/rvm-installer && rm /root/rvm-installer'",
        path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
        creates => '/usr/local/rvm/bin/rvm',
        timeout => '120',
       # require => Package ['ftp/curl'],
      }
    }
	}  
}
