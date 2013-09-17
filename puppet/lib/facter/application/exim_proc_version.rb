# Fact: exim_proc_version
# Purpose: determine the exim proc version on FreeBSD hosts
#
# Resolution:
#   Output of:
#     ruby equivalent of: 
#      ps -Af | grep exim | cut -f 2 -d '('|sed -e 's/)//g' | head -1 
#     returns the exim version; e.g: exim-4.80.1-0 if exim is running
#      if exim is stopped; it will return: exim as the fact
#       The check_snmp_proc will return:
#        No exim process running
#
# Caveats:
#   None
# 
# Notes:
#   None
#
Facter.add(:exim_proc_version) do
confine :operatingsystem => %w{FreeBSD}
  setcode do
    test = `ps -Af | grep exim`.lines.first.strip
    if test.nil?
      exim_proc_version = "exim"
    elsif test.match(/\(|\)/)
      #result = test.split(/\(|\)/)[1].split(/-/)[1]
      result = test.split(/\(|\)/)[1]
      if not result.empty?
        exim_proc_version = result
      end
    end
  end
end  