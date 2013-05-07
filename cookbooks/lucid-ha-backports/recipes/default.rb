#
# Cookbook Name:: lucid-ha-backports
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

# add the lucid ha backports ppa; grab key from keyserver
apt_repository "lucid-ha-backports" do
  uri "http://ppa.launchpad.net/ubuntu-ha-maintainers/ppa/ubuntu"
  distribution node['lsb']['codename']
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "56497ED8"
end

package "libglib2" do
    package_name "libglib2.0-0"
    action :upgrade
end

package "corosync" do
    package_name "corosync"
    action :install
end

package "pacemaker" do
    package_name "pacemaker"
    action :install
end

package "openais" do
    package_name "openais"
    action :install
end

package "ocfs2-tools-pacemaker" do
    package_name "ocfs2-tools-pacemaker"
    action :install
end

package "dlm-pcmk" do
    package_name "dlm-pcmk"
    action :install
end

package "nfs-kernel-server" do
    package_name "nfs-kernel-server"
    action :install
end

execute "move corosync support files into place" do
    command "cp /vagrant/linux-ha/corosync.conf /etc/corosync/; cp /vagrant/linux-ha/authkey /etc/corosync/; cp /vagrant/linux-ha/pacemaker /etc/corosync/service.d/"
end

execute "enable corosync init.d script" do
    command "sed -i -e 's/START=no/START=yes/' /etc/default/corosync"
end