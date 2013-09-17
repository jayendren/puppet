# Fact: dovecot_version
# Purpose: determine the dovecot version
#
# Resolution:
#   Output of: dovecot --version
#
# Caveats:
#   None
# 
# Notes:
#   None
#
Facter.add(:dovecot_version) do
  setcode do
    test = Facter::Util::Resolution.exec("dovecot --version")
    if test.nil?
      dovecot_version = "NOT_INSTALLED"
    else
      result = test.strip.lines.first.strip
      if not result.empty?
        dovecot_version = result
      end
    end
  end
end