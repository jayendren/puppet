# Fact: mysql_version
# Purpose: determine the mysql_(client,server) version
#
# Resolution:
#   Client:
#     Output of: mysql --version
#   Server:
#     FreeBSD:
#      match mysql_enable="YES" in /etc/rc.conf
#        if true, mysql_server_version = mysql_client_version
#     Solaris, RedHat, CentOS, Ubuntu:
#      test if mysqld process is running in background:
#       ps -ef|grep [m]ysql|grep -v [j]ava|grep [m]ysqld|grep -v [m]ysqld_safe
#      
#
# Caveats:
#   Solaris/Linux server_version checks if the process is running in background.
# 
# Notes:
#   None
#
Facter.add(:mysql_client_version) do
  setcode do
    test = Facter::Util::Resolution.exec("mysql --version")
    if test.nil?
      mysql_client_version = "NOT_INSTALLED"
    else
      result = test.strip.lines.first.split(/,/)[0].gsub(/mysql|Ver|\/usr\/bin\/|\/usr\/local\/bin\/|\/opt\/\/server\-5.5\/bin\//, "").strip
      if not result.empty?
        mysql_client_version = result
      end
    end
  end
end

Facter.add(:mysql_server_version) do
confine :operatingsystem => :FreeBSD  
  setcode do
    rc_conf_test = `grep -w 'mysql_enable="YES"' /etc/rc.conf`.strip
    if rc_conf_test.to_s.match(/YES/)
      mysql_server_version = Facter.value("mysql_client_version")
    else
      mysql_server_version = "NOT_INSTALLED"
    end
  end
end 

Facter.add(:mysql_server_version) do
confine :operatingsystem => %w{Solaris RedHat CentOS Ubuntu}
  setcode do
    test_proc = `ps -ef|grep [m]ysql|grep -v [j]ava|grep [m]ysqld|grep -v [m]ysqld_safe`.strip
    if test_proc.to_s.match(/mysqld/)
      mysql_server_version = Facter.value("mysql_client_version")
    else
      mysql_server_version = "NOT_INSTALLED"
    end
  end
end 