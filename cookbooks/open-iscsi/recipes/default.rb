#
# Cookbook Name:: open-iscsi
# Recipe:: default
#
# Copyright 2013, hastexo GMBH
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

package "open-iscsi" do
    package_name "open-iscsi"
    action :install
end

execute "get targets on alice" do
    command "iscsiadm -m discovery -t sendtargets -p 192.168.122.114"
end

execute "login to target 1 on alice" do
    command "iscsiadm --mode node --targetname iqn.2001-04.com.example:storage.disk2.amiens.sys1.xyz --portal 192.168.122.114:3260 --login"
end
