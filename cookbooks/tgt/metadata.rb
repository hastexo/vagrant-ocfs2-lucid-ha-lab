name              "tgt"
maintainer        "hastexo GMBH"
maintainer_email  "noah.mehl@hastexo.com"
license           "GPL"
description       "Install and configures (eventually) tgt"
long_description  "This cookbook includes recipes to install tgt and configure it (eventually) on the local node."
version           "0.0.1"

%w{ ubuntu debian }.each do |os|
  supports os
end
