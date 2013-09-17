# Fact: processor1
#
# Purpose:
# Get the CPU {model,freqency} on a FreeBSD/SunOS Servers
#
# Resolution:
#  Uses output of 'sysctl hw.model'
#
# Caveats:
#  none
#
# Notes:
#   None
#
Facter.add("processor1") do
  confine :kernel => :FreeBSD
  setcode do
    result = `sysctl hw.model`.split(/:/)[1].chomp.strip
    if result.nil?
      processor1 = "UNKNOWN"
    else
      processor1 = result
    end
  end
end
Facter.add("processor1") do  
  confine :kernel => :SunOS
  setcode do
    result = `/usr/bin/kstat -m cpu_info|grep implementation|head -1`.split(/implementation/)[1].strip
    if result.nil?
      processor1 = "UNKNOWN"
    else
      processor1 = result
    end
  end  
end