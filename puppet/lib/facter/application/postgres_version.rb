# Fact: postgres_version
# Purpose: determine the postgres client/server version
#
# Resolution:
#   client:
#    Output of psql --version
#   server:
#    Output of postmaster --version
#   
#
#
# Caveats:
#   None
# 
# Notes:
#   None
#
Facter.add(:postgres_client_version) do
  setcode do
    binpath = Facter::Util::Resolution.exec('pg_config --bindir')
    Facter::Util::Resolution.exec("#{binpath}/psql --version| head -n 1 |cut -d ' ' -f 3")
  end
end

Facter.add(:postgres_server_version) do
  setcode do
    binpath = Facter::Util::Resolution.exec('pg_config --bindir')
    Facter::Util::Resolution.exec("#{binpath}/postmaster --version| head -n 1 |cut -d ' ' -f 3")
  end
end