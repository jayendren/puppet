# Fact: proftp_version
# Purpose: determine the proftp version
#
# Resolution:
#   Output of: proftpd --version
#
# Caveats:
#   None
# 
# Notes:
#   None
#
Facter.add(:proftp_version) do
  setcode do
    test = Facter::Util::Resolution.exec("proftpd --version")
    if test.nil?
      proftp_version = "NOT_INSTALLED"
    else
      result = test.strip.lines.first.split(/ /)[2].strip
      if not result.empty?
        proftp_version = result
      end
    end
  end
end