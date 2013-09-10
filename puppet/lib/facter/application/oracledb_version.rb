# Fact: oracledb_version
# Purpose: determine the server's Oracle Database version
#
# Resolution:
#   Output of shell script distributed by puppet:
#    /usr/local/bin/oracledb_version.sh 
#
#
# Caveats:
#   Oracle Database or tnslsnr process must be in a running state
# 
# Notes:
#   None
#

Facter.add(:oracledb_version) do
confine :operatingsystem => %w{Solaris RedHat}
  setcode do
    if File.exist? "/usr/local/bin/oracledb_version.sh"
      script = `/usr/local/bin/oracledb_version.sh`.chomp     
      if not script.nil?        
        oracledb_version = script.to_s.strip
      else
        oracledb_version = "UNKNOWN"
      end
    else
      oracledb_version = "NOT_INSTALLED"
    end
  end
end