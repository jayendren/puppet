# Fact: serialnumber
#
# Purpose: Returns the system's serialnumber on solaris SPARC servers
#
# Resolution:
#   return "prtdiag -v|tail -1" or eeprom |grep Cha|cut -f 3 -d ' '
#   if the length is < 10 characters, then the result is unknown
#
# Caveats:
#   search: SI_HW_SERIAL and SUNWsneep to manually grab the Chassis Serial and store it in EEPROM
#
# Notes:
#   None
#

Facter.add(:serialnumber) do
  confine :operatingsystem => %w{Solaris}
  setcode do
    require 'facter/util/manufacturer'
    Facter::Manufacturer.sysctl_find_system_info(mfg_keys)
    Facter.value(:kernel) == "SunOS" and Facter.value(:hardwareisa) == "sparc"
  end
  setcode do
    require 'facter/util/config'
    result = %x{prtdiag -v|tail -1}.chomp
       if (result.length != 10)
          result = %x{eeprom |grep ChassisSerialNumber|cut -f 3 -d ' '}.chomp
          if (result.length != 10)
              result = "UNKNOWN"
          end
       end
    result
  end
end
