require 'net/ssh/telnet'

ssh = Net::SSH.start('192.168.99.1', 'admin',
  password: ".pk!!zVeAF3*NnBEiwFX",
  config: true,
  host_key: '+ssh-dss',
  kex: '+diffie-hellman-group1-sha1'
)

s = Net::SSH::Telnet.new("Dump_log" => "/dev/null", "Session" => ssh, "Prompt" => %r{ICX6610-48P>})

puts "Logged in"
s.cmd({ "String" => "enable", "Match" => %r{User Name:} })
s.cmd({ "String" => "admin", "Match" => %r{Password:} })
s.cmd({ "String" => ".pk!!zVeAF3*NnBEiwFX", "Match" => %r{ICX6610-48P#} })
s.cmd({ "String" => "config t", "Match" => %r{\(config\)#$} })
s.cmd({ "String" => "interface ethernet 1/3/2", "Match" => %r{1/3/2\)#$} })
# not having to escape "/" here is a feture of ruby's r%{}
in_output = s.cmd({ "String" => "rate-limit input fixed 8000", "Match" => %r{1/3/2\)#$} })
out_output = s.cmd({ "String" => "rate-limit output shaping 8000", "Match" => %r{1/3/2\)#$} })
s.cmd({ "String" => "exit", "Match" => %r{\(config\)#$} })
s.cmd({ "String" => "exit", "Match" => %r{ICX6610-48P#} })
write_mem_output = s.cmd({ "String" => "write mem", "Match" => %r{ICX6610-48P#} })
s.cmd("exit")
s.cmd("exit")

puts "#{in_output.to_s}\n#{out_output.to_s}\n#{write_mem_output.to_s}\n"
