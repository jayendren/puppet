# Fact: firewall_status
#
# Purpose: determine the firewall status on the host
#
# Resolution:
#   per operating system:
#   1. get firewall_type status ($HFW variable), 
#   2. execute status checks based on the firewall_type
#   3. Report firewall_type = Enabled or Disabled
#
# Caveats:
#   none
# 
# Notes:
#   None

Facter.add(:firewall_status) do
  $HFW = $HFW, nil
  $HFW = Facter.value(:firewall_type)      
    if Facter.value(:operatingsystem).match("FreeBSD")  
        setcode do
          if $HFW.match("FreeBSD_PF")
            result = %x{/sbin/pfctl -s info -q|head -1}.chomp
            if result.match("Enabled")
              firewall_status = "Enabled"
            else 
              firewall_status = "Disabled"   
          end  
        
          elsif $HFW.match("FreeBSD_IPFW")
            result = %x{/sbin/sysctl net.inet.ip.fw.enable}.chomp
            if result.match("1")
              firewall_status = "Enabled"
            else 
              firewall_status = "Disabled"   
            end
          end     
        end
        
    elsif Facter.value(:operatingsystem).match("Solaris")                
        setcode do  
          if $HFW.match("Solaris_IPFilter")
          #firewall_type checks if service is running, so          
            firewall_status = "Enabled"
          else 
            firewall_status = "Disabled"     
        end          
    end 
             
    elsif Facter.value(:operatingsystem).match(/RedHat|Ubuntu|CentOS/)                
        setcode do  
          if $HFW.match("Linux_IPTables")
          #firewall_type checks if service is running, so                    
            firewall_status = "Enabled"
          else 
            firewall_status = "Disabled"   
        end                  
    end          
    
  end
end
