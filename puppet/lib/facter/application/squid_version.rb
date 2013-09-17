# Fact: squid_version
# Purpose: determine the squid version
#
# Resolution:
#   Output of:
#     squid -v
#
# Caveats:
#   None
# 
# Notes:
#   None
#
Facter.add(:squid_version) do
  setcode do
    test = Facter::Util::Resolution.exec("squid -v")
    if test.nil?
      squid_version = "NOT_INSTALLED"
    else
      result = test.strip.lines.first.split(/Version/)[1].strip
      if not result.empty?
        squid_version = result
      end
    end
  end
end  