# Fact: physical_memory
#
# Purpose:
#  Get the total amount of physical memory installed on a Server in Megabytes
#
# Resolution:
#  FreeBSD:
#   Uses out of 'sysctl -n hw.physmem'
#
#  RedHat, CentOS, Ubuntu:
#   Uses output of free
#
#  Solaris:
#   Uses output of prtconf | grep "Memory size"
#
# Caveats:
#  none
#
# Notes:
#   None
#
Facter.add("physical_memory") do
  confine :kernel => :FreeBSD
  setcode do
    memtotal = Facter::Util::Resolution.exec("sysctl -n hw.physmem")
    memtotal_MB = (Integer(memtotal) /1024) /1024 
    physical_memory = "#{memtotal_MB} " + "MB"
  end
end

Facter.add("physical_memory") do
  confine :operatingsystem => %w{RedHat Centos Ubuntu}
  setcode do
    memtotal_KB = (`free`.split(" ")[7]).to_i
    memtotal_MB = memtotal_KB / 1024
    physical_memory = "#{memtotal_MB} " + "MB"
  end
end

Facter.add("physical_memory") do
  confine :operatingsystem => :Solaris
  setcode do
    memtotal_MB = (`prtconf | grep "Memory size"`).strip.split(/:/)[1].split(" ")[0].to_i
    physical_memory = "#{memtotal_MB} " + "MB"
  end
end