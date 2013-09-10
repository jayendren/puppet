# Fact: java_version
#
# Purpose: store java versions in the config DB
#
# Resolution:
#   tests for presence of java;
#   returns output of "java -version" and splits on \n + '"'
#
# Caveats:
#   none  
# 
# Notes:
#   None

Facter.add(:java_version) do
  setcode do
    t_java = `which java`
    if t_java.empty?
      java_version = "NOT_INSTALLED"
    else
      j_version = `java -version 2>&1`.to_s.split("\n")[0].split('"')[1]
      if not j_version.nil?
        java_version = j_version
      else
       java_version = "NOT_INSTALLED"
      end
    end
  end
end