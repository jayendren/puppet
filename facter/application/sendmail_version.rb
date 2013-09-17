# Fact: sendmail_version
# Purpose: determine the sendmail version
#
# Resolution:
#   Output of:
#     sendmail -v -d0.1 < /dev/null
#
# Caveats:
#   None
# 
# Notes:
#   None
#
Facter.add(:sendmail_version) do
  setcode do
    test = Facter::Util::Resolution.exec("sendmail -v -d0.1 < /dev/null")
    if test.nil?
      sendmail_version = "NOT_INSTALLED"
    else
      result = test.strip.lines.first.split(/Version/)[1].strip
      if not result.empty?
        sendmail_version = result
      end
    end
  end
end  