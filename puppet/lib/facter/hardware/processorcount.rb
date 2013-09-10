# Fact: processorcount
#
# Purpose:
# Get the number of CPU's installed on a FreeBSD Server
#
# Resolution:
#  Uses output from 'sysctl hw.ncpu'
#
# Caveats:
#  none
#
# Notes:
#   None
#
Facter.add("processorcount") do
  confine :kernel => :FreeBSD
  setcode do
    result = `sysctl hw.ncpu`.split(/:/)[1].chomp.strip
    if result.nil?
      processorcount = "UNKNOWN"
    else
      processorcount = result
    end
  end
end