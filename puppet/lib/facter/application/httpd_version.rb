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
    t_apache = `which httpd`
    if t_apache.empty?
      httpd_version = "NOT_INSTALLED"
    else    
      a_version = `httpd -v | grep version`.split(/:|\/|\(/)[2].strip
      if a_version.nil?
        httpd_version = "NOT_INSTALLED"
      else
        httpd_version = a_version
      end
    end
  end
end

Facter.add(:httpd_version) do
confine :operatingsystem => %w{RedHat Centos Ubuntu}
  setcode do
    t_apache = `which apachectl`
    if t_apache.empty?
      httpd_version = "NOT_INSTALLED"
    else    
      a_version = `apachectl -v | grep version`.split(/:|\/|\(/)[2].strip
      if a_version.nil?
        httpd_version = "NOT_INSTALLED"
      else
        httpd_version = a_version
      end
    end
  end
end
