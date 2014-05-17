#
# Cookbook Name:: nat-router
# Recipe:: default
#
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

package 'iptables'

directory "/etc/sysctl.d" do
  owner "root"
  group "root"
  mode 0644
end

template '/etc/sysctl.d/60-network-forwarding.conf' do
  source 'network-forwarding.conf.erb'
  mode 0644
  owner 'root'
  group 'root'
end

execute 'iptables-restore' do
  command '/sbin/iptables-restore < /etc/network/iptables'
  action :nothing
end

template '/etc/network/iptables' do
  source 'iptables.erb'
  mode 0644
  owner 'root'
  group 'root'
  notifies :run, resources(:execute => 'iptables-restore')
end

template '/etc/network/if-pre-up.d/iptables-restore' do
  source 'iptables-restore.erb'
  mode 0755
  owner 'root'
  group 'root'
end