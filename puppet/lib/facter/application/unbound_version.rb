# Fact: unbound_version
# Purpose: determine the unbound version
#
# Resolution:
#   Output of:
#     unbound -h|grep Version
#
# Caveats:
#   None
# 
# Notes:
#   None
#
Facter.add(:unbound_version) do
  setcode do
    test = Facter::Util::Resolution.exec("unbound -h|grep Version")
    if test.nil?
      unbound_version = "NOT_INSTALLED"
    else
      result = test.split(/Version/)[1].strip
      if not result.empty?
        unbound_version = result
      end
    end
  end
end  