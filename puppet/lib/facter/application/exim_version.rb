# Fact: exim_version
# Purpose: determine the exim version
#
# Resolution:
#   Output of:
#     exim -bV
#
# Caveats:
#   None
# 
# Notes:
#   None
#
Facter.add(:exim_version) do
  setcode do
    test = Facter::Util::Resolution.exec("exim -bV")
    if test.nil?
      exim_version = "NOT_INSTALLED"
    else
      result = test.split(/version|\#/)[1].strip
      if not result.empty?
        exim_version = result
      end
    end
  end
end  