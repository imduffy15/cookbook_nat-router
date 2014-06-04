maintainer       "Ian Duffy"
maintainer_email "ian@ianduffy.ie"
license          "Apache 2.0"
description      "Configures iptables as a nat firewall"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

%w{ redhat centos scientific amazon }.each do |os|
  supports os
end

recipe "nat-router", "Configures iptables as a nat firewall"
