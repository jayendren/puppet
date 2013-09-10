# Fact: munin_perlproc_version
# Purpose: determine the perl proc version for munin on FreeBSD hosts
#
# http://perldoc.perl.org/perlvar.html
# > Note for BSD users: setting $0 does not completely remove "perl" from the ps(1) output. 
# > For example, setting $0 to "foobar" may result in "perl: foobar (perl)" 
# > (whether both the "perl: " prefix and the " (perl)" suffix are shown depends 
# > on your exact BSD variant and version). This is an operating system feature, 
# > Perl cannot help it.
#
# Resolution:
#   Output of:
#     ruby equivalent of: 
#      ps -Af | grep munin-node | grep -v facter | cut -f 2 -d '('|sed -e 's/)//g' | head -1 | grep perl
#     returns the perlversion; e.g: perl5.12.4 if munin-node is running
#      if munin-node is stopped; it will return: munin-node as the fact
#       The check_snmp_proc will return:
#        No munin-node process running
#
# Caveats:
#   FreeBSD hosts that report the following output:
#    80178  ??  Ss     0:00.08 /usr/local/bin/perl -wT /usr/local/sbin/munin-node
#    will set the fact to perl
# 
# Notes:
#   None
#
Facter.add(:munin_perlproc_version) do
confine :operatingsystem => %w{FreeBSD}
  setcode do
    test = `ps -Af | grep munin-node | grep -v facter | grep perl`.strip.lines.first
    if test.nil?
      munin_perlproc_version = "munin-node"
    elsif test.match(/\(|\)/)
      result = test.split(/\(|\)/)[1]
      if not result.empty?
        munin_perlproc_version = result
      end
    else test.match("perl")
      munin_perlproc_version = "perl"
    end
  end
end  