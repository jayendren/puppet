# Fact: bind_version
# Purpose: determine the bind_{client,server} version
#
# Resolution:
#   Client:
#    Output of:
#      named -v
#   Server:
#    FreeBSD:
#     tests if named_enable="YES" exists in rc.conf
#     if true, bind_server_version = bind_client_version
#    
#
# Caveats:
#   None
# 
# Notes:
#   None
#
Facter.add(:bind_client_version) do
  setcode do
    test = Facter::Util::Resolution.exec("named -v 2>&1")
    if ((test.nil?) or (test.match(/failed|neither/)))
      bind_client_version = "NOT_INSTALLED"
    else
      result = test.split(/ /)[1].strip
      if not result.empty?
        bind_client_version = result
      end
    end
  end
end  

Facter.add(:bind_server_version) do
confine :operatingsystem => :FreeBSD  
  setcode do
    rc_conf_test = `grep -w 'named_enable="YES"' /etc/rc.conf`.strip
    if rc_conf_test.to_s.match(/YES/)
      bind_server_version = Facter.value("bind_client_version")
    else
      bind_version = "NOT_INSTALLED"
    end
  end
end  