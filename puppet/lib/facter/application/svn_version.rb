# Fact: postgres_version
# Purpose: determine the version of devel/subversion version
#
# Resolution:
#    Output of /usr/sbin/pkg_info | grep subversion on FreeBSD, returns fact if not empty,
#    else reports NOT_INSTALLED
#
# Caveats:
#   None
# 
#
Facter.add(:svn_version) do
confine :operatingsystem => :FreeBSD
  setcode do
    t_svn = `/usr/sbin/pkg_info | grep subversion 2>&1`
    if t_svn.empty?
      svn_version = "NOT_INSTALLED"
    else    
      s_version = `/usr/sbin/pkg_info | grep subversion | grep -v py 2>&1`.split(/ /)[0].split(/-/)[1].strip
      if s_version.nil?
        svn_version = "NOT_INSTALLED"
      else
        svn_version = s_version
      end
    end
  end
end