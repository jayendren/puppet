# = Class: rvm::system
#
#   - This class is capable of installing a specific ruby version, with the option of setting as default.
#    - Supported operatingsystems:
#     - FreeBSD
#
# == Parameters:
#
#   - $version,$ensure,$default
#
# == Actions:
#
#   - Install:
#    - exec { 'install_rvm_rubies' }
#   - Remove:
#    - exec { 'remove_rvm_rubies' }
#   - Set default:
#   - exec { 'set_rvm_default_ruby' }
#
# == Requires:
#
#   - Parameter $version must be valid and not empty,
#   - Class ['rvm::install']
#
# == Sample Usage:
#    
#   - install ruby 1.8.7:
#    class { 'rvm::system':
#      version => '1.8.7',
#      ensure  => present,
#    }
#
#   - install ruby 1.9.3 as default:
#    class { 'rvm::system':
#      version => '1.9.3',
#      ensure  => present,
#      default => true,
#    }
#
# === Authors
#
#   - Jayendren Maduray <jayendren@gmail.com>
#
#
class rvm::system($version,$ensure,$default) {
	include rvm::install
  Exec {
    path    => ['/sbin','/bin','/usr/sbin','/usr/bin','/usr/local/bin','usr/local/sbin','/usr/local/rvm/bin'],
  }
	case $::operatingsystem {
		FreeBSD: {
	    $rvm_bin = "rvm"

	    if $version == "" {
	  	  notice "empty version NOT supported"
	    }

      if $ensure == 'present' {

        exec { 'install_rvm_rubies':
          command => "${rvm_bin} install ${version}",
          unless  => "${rvm_bin} list | grep ${version} 2>/dev/null",
          require => Class['rvm::install'],
          timeout => '900',
        }

      } elsif $ensure == 'absent' {

        exec { 'remove_rvm_rubies':
          command => "${rvm_bin} remove ${version}",
          onlyif  => "${rvm_bin} list | grep ${version} 2>/dev/null",
          require => Class['rvm::install']
        }
      }

      case $default {
    	  true: {
    		  exec { 'set_rvm_default_ruby':
    		    command => "${rvm_bin} alias create default ${version}",
            unless  => "${rvm_bin} list | grep '=*' | grep '${version}' 2>/dev/null",
            require => Class['rvm::install'],
    	    }
    	  }
      }

    }
	}  
}
