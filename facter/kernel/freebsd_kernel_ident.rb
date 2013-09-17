# Fact: freebsd_kernel_ident
# Purpose: determine the kernel ident on FreeBSD hosts
#
# Resolution:
#   Output of:
#     uname -i
#   Returns UNKNOWN if Output is empty
#
# Caveats:
#   None
# 
# Notes:
#   None
#

Facter.add(:freebsd_kernel_ident) do
confine :operatingsystem => %w{FreeBSD}
   setcode do
     result = `uname -i`
     result.strip!
     if result.empty?
       freebsd_kernel_ident = "UNKNOWN"
     else
       freebsd_kernel_ident = result.strip
     end
  end
end
