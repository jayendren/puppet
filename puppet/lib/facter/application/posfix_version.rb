# Fact: postfix_version
# Purpose: determine the postfix version
#
# Resolution:
#   Output of: postconf mail_version
#
# Caveats:
#   None
# 
# Notes:
#   None
#
Facter.add(:postfix_version) do
  setcode do
    test = Facter::Util::Resolution.exec("postconf mail_version")
    if test.nil?
      postfix_version = "NOT_INSTALLED"
    else
      result = test.strip.lines.first.split(/\=/)[1].strip
      if not result.empty?
        postfix_version = result
      end
    end
  end
end