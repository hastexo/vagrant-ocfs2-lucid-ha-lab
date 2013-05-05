#
# Cookbook Name:: tgt
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

package "tgt" do
    package_name "tgt"
    action :install
end

execute "start tgtd" do
    command "/usr/sbin/tgtd"
end

execute "create target" do
    command "tgtadm --lld iscsi --op new --mode target --tid 1 -T iqn.2001-04.com.example:storage.disk2.amiens.sys1.xyz"
end

execute "attach disk to target" do
    command "tgtadm --lld iscsi --op new --mode logicalunit --tid 1 --lun 1 -b /dev/sdb"
end

execute "accept all initiators on target 1" do
    command "tgtadm --lld iscsi --op bind --mode target --tid 1 -I ALL"
end