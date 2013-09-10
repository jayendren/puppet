# Fact: primary_interface
#
# Purpose: determine the server's primary interface
#
# Resolution:
#   Use the output of:
#     ifconfig -a|grep ops_if0|awk {'print $1'}
#     ^ if the above matches, then ops_if0 is the primary interface
#     else
#      FreeBSD/Solaris:
#       route -n get 196.11.240.17|grep interface|cut -f 2 -d ':' |sed 's/ //g'
#      RedHat Centos Ubuntu:
#       ip route get 196.11.240.17|awk {'print $5'}|head -1 
#     If the result is empty primary_interface is set to UNKNOWN
#
# Caveats:
#   none
# 
# Notes:
#   None
#

Facter.add(:primary_interface) do
confine :operatingsystem => %w{FreeBSD Solaris}
   setcode do
     pri_if = %x{ifconfig -a|grep ops_if0|awk {'print $1'}}.chomp
     if pri_if.match("ops_if0")
       primary_interface = "ops_if0"
       else
         pri_if = %x{route -n get 196.11.240.17|grep interface|cut -f 2 -d ':' |sed 's/ //g'}.chomp
         if not pri_if.nil?
           primary_interface = pri_if
           else
           primary_interface = "UNKNOWN"
        end
     end
  end
end

Facter.add(:primary_interface) do
confine :operatingsystem => %w{RedHat Centos Ubuntu}
  setcode do
     pri_if = %x{ifconfig -a|grep ops_if0|awk {'print $1'}}.chomp
     if pri_if.match("ops_if0")
       primary_interface = "ops_if0"
       else
         pri_if = %x{ip route get 196.11.240.17|awk {'print $5'}|head -1}.chomp
         if not pri_if.nil?
           primary_interface = pri_if
           else
           primary_interface = "UNKNOWN"
        end
     end
  end
end
