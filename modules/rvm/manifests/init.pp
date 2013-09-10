# = Class: rvm
#
#   - This class is capable of installing a specific ruby version, with the option of setting as default.
#    - Supported operatingsystems:
#     - FreeBSD
#
# == Parameters:
#
#   - $ruby_version,$ensure,$default
#
# == Actions:
#
#   - Using Parameters, executes:
#    class { 'rvm::system':
#      version => "$ruby_version",
#      ensure  => "$ensure",
#      default => $default,
#    }
#
# == Requires:
#
#   - Class ['rvm::install']
#
# == Sample Usage:
#    
#  - Install ruby 1.9.3, and set as default:
#   class { rvm:
#     ruby_version => '1.9.3',
#     default      => true,
#   }
#
#  - Install ruby 1.8.7 (not default):
#   class { rvm:
#     ruby_version => '1.8.7',
#     default      => false,
#   }
#
#  - Remove ruby version:
#   class { rvm:
#     ruby_version => '1.9.3',
#     ensure       => 'absent',
#   }
#
# === Authors
#
#   - Jayendren Maduray <jay.maduray@mtnbusiness.co.za>
#
#
class rvm(
	$ruby_version,
	$ensure = "present",
	$default
) {
  
  class { 'rvm::system':
    version => "$ruby_version",
    ensure  => "$ensure",
    default => $default,
  }
}
