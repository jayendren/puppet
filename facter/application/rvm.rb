# Fact: rvm
# Purpose: determine the following:
#   rvm_version
#   rvm_default_ruby
#   rvm_default_gem
#   rvm_facter_version
#   rvm_facter_lib
#
# Resolution:
#    
#
# Caveats:
#   None
# 
#
Facter.add(:rvm_version) do
confine :operatingsystem => :FreeBSD
  setcode do
    if File.exist? "/usr/local/rvm/bin/rvm"
      t_rvm = `/usr/local/rvm/bin/rvm -v|grep -v Saving`
      if t_rvm.empty?
        rvm_version = "NOT_INSTALLED"
      else    
        rvm_version = t_rvm.split(/\(/)[0].split(" ")[1]
      end
    else
      rvm_version = "NOT_INSTALLED"
    end
  end
end

Facter.add(:rvm_default_ruby) do
confine :operatingsystem => :FreeBSD
  setcode do
    if Facter.value(:rvm_version) == "NOT_INSTALLED"
      rvm_default_ruby = "RVM_NOT_INSTALLED"
    else    
      t_rvm_default = `/usr/local/rvm/bin/rvm list|grep '=*'|grep -vE 'Saving|#'`.split(/\*|\[/)[1].to_s.strip
      if t_rvm_default.nil?
        rvm_default_ruby = "NOT_SET"
      else
        rvm_default_ruby = t_rvm_default
      end
    end
  end
end

Facter.add(:rvm_default_gem) do
confine :operatingsystem => :FreeBSD
  setcode do
    if Facter.value(:rvm_version) == "NOT_INSTALLED"
      rvm_default_gem = "RVM_NOT_INSTALLED"
    else  
      t_rvm_default_gem = `/usr/local/rvm/rubies/default/bin/gem -v`.strip
      if t_rvm_default_gem.nil?
        rvm_default_gem = "NOT_SET"
      else
        rvm_default_gem = t_rvm_default_gem
      end
    end
  end
end

Facter.add(:rvm_facter_version) do
confine :operatingsystem => :FreeBSD
  setcode do
    if Facter.value(:rvm_version) == "NOT_INSTALLED"
      rvm_facter_version = "RVM_NOT_INSTALLED"
    else    
      t_rvm_facter_version = `/usr/local/rvm/rubies/default/bin/gem list|grep facter`.split(/\(|\)/)[1].to_s.strip
      if t_rvm_facter_version.nil?
        rvm_facter_version = "NOT_INSTALLED"
      else
        rvm_facter_version = t_rvm_facter_version
      end
    end
  end
end

Facter.add(:rvm_facter_lib) do
confine :operatingsystem => :FreeBSD
  setcode do
    if Facter.value(:rvm_version) == "NOT_INSTALLED"
      rvm_facter_lib = "RVM_NOT_INSTALLED"
    else    
      rdr = Facter.value(:rvm_default_ruby)
      rfv = Facter.value(:rvm_facter_version)
      t_rvm_facter_lib = "/usr/local/rvm/gems/#{rdr}/gems/facter-#{rfv}/lib/facter"
      if t_rvm_facter_lib.nil?
        rvm_facter_lib = "NOT_SET"
      else
        rvm_facter_lib = t_rvm_facter_lib
      end
    end
  end
end