# Fact: network_asn
#
# Purpose: determine the server's Autonomous System Number
#
# Resolution:
#   based on fqdn fact,
#    if it contains /xp|rb|jp|tb|jh|bl|ls/ or /xp-|rb-|jp-|tb-|jh-|bl-|ls-/ then ASN = 16637
#    if it contains /cpt1|jnb6/ or /cpt1-|jnb6-/ ASN = 2905
#    if does not, it is set to UNKNOWN
#
# Caveats:
#   none  
# 
# Notes:
#   None

Facter.add(:network_asn) do
  setcode do
    n_as = Facter.value('fqdn')
    case n_as
    when /xp|rb|jp|tb|jh|bl|ls|xp-|rb-|jp-|tb-|jh-|bl-|ls-/
      "16637"
    when /cpt1|jnb6|cpt1-|jnb6-/
      "2905"   
    else
      n_as = "UNKNOWN"
    end
  end
end
