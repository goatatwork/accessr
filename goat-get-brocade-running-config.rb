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
s.cmd({ "String" => "skip-page-display", "Match" => %r{ICX6610-48P#} })
running_config = s.cmd({ "String" => "show running-config", "Match" => %r{ICX6610-48P#} })

s.cmd("exit")
s.cmd("exit")

puts "#{running_config.to_s}"

