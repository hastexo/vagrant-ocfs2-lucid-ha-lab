corosync_key=File.join(File.dirname(__FILE__), "linux-ha", "authkey")

task :gen_keys do
  system "mkdir .ssh"
  system "ssh-keygen -f .ssh/id_rsa -N ''"
  system "cp -a .ssh/id_rsa.pub .ssh/authorized_keys2"
  system "dd if=/dev/random of=#{corosync_key} bs=128 count=1"
end

task :clean do
  system "rm -r .ssh"
  system "rm #{corosync_key}"
end
