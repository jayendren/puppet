# Fact: httpd_version
# Purpose: determine the apache server version
#
# Resolution:
#    Output of httpd -v on FreeBSD, Output of apachectl -v on RedHat,CentOS,Ubuntu
#
# Caveats:
#   None
# 
#
Facter.add(:httpd_version) do
confine :operatingsystem => :FreeBSD
  setcode do
    test = Facter::Util::Resolution.exec("httpd -v | grep version")
    if test.nil?
      httpd_version = "NOT_INSTALLED"
    else    
      httpd_version = test.split(/:|\/|\(/)[2].strip
    end
  end
end

Facter.add(:httpd_version) do
confine :operatingsystem => %w{RedHat Centos Ubuntu}
  setcode do
    test = Facter::Util::Resolution.exec("apachectl -v | grep version")
    if test.nil?
      httpd_version = "NOT_INSTALLED"
    else    
      httpd_version = test.split(/:|\/|\(/)[2].strip
    end
  end
end

Facter.add(:httpd_version) do #broadworks and solaris servers
  if Facter.server_class.to_s.match(/Solaris_Broadworks_VOIP_Server/)
    setcode do
      test = Facter::Util::Resolution.exec("/usr/local/apache/apache_base/bin/apachectl -v | grep version")
      if test.nil?
        httpd_version = "NOT_INSTALLED"
      else
        httpd_version = test.split(/:|\/|\(/)[2].strip
      end
    end
  elsif Facter.operatingsystem.to_s.match(/Solaris/)
    setcode do
      test = Facter::Util::Resolution.exec("/usr/apache2/bin/apachectl -v | grep version")
      if test.nil?
        httpd_version = "NOT_INSTALLED"
      else
        httpd_version = test.split(/:|\/|\(/)[2].strip
      end
    end    
  end
end
