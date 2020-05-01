# To validate auto.direct file and mount if something unmount

file "/etc/auto.custom" do
  not_if {::File.exists? '/etc/auto.custom'}
  action :nothing
end

nasmount = Mixlib::ShellOut.new("cat /etc/auto.custom | egrep -v '^#' > /etc/nasmount").run_command
nasmount.error!
fsname = Mixlib::ShellOut.new("cat /etc/nasmount | awk '{print $1}' > /tmp/fsname").run_command
fsname.error!

#To start autofs service if down
service 'autofs' do
  action [:start, :enable]
end

# read line by line and cd to mount directory
File.open("/tmp/fsname", "r") do |file|
  file.each_line do |line|
    puts "cd #{line} "
    `cd #{line}`
  end
end
