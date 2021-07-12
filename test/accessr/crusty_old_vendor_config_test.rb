require "test_helper"

class CrustyOldVendorConfigTest < ActionDispatch::IntegrationTest

  include Accessr::TalksToHardware

  test "should place initialized configuration text in an instance variable named original_input." do
    config = CrustyOldVendorConfig.new("bla bla bla")

    assert_equal "bla bla bla", config.original_input
  end

  test "should split the config file into blocks" do
    config = CrustyOldVendorConfig.new(fake_fastiron_config)

    assert_equal 69, config.as_array.count
  end

  test "should be able to find the block for a specific ethernet interface" do
    config = CrustyOldVendorConfig.new(fake_fastiron_config)

    assert_equal self.fake_fastiron_interface_config_as_array, config.interface("1/1/13")
  end

  test "should retrieve input rate limit setting for a port" do
    config = CrustyOldVendorConfig.new(fake_fastiron_config)

    assert_equal "3000", config.input_rate_limit("1/1/13")
  end

  test "should retrieve output rate limit setting for a port" do
    config = CrustyOldVendorConfig.new(fake_fastiron_config)

    assert_equal "24998", config.output_rate_limit("1/1/13")
  end

  test "should retrieve output rate limit setting for a port again" do
    # config = CrustyOldVendorConfig.new(fake_fastiron_config).output_rate_limit("1/1/13")

    assert_equal "24998", CrustyOldVendorConfig.new(fake_fastiron_config).output_rate_limit("1/1/13")
  end

  def fake_fastiron_interface_config_as_array
    ["interface ethernet 1/1/13",
      "disable",
      "rate-limit input fixed 3000",
      "rate-limit output shaping 24998"
    ]
  end

  def fake_fastiron_config
    content = <<~FAKE_CONFIG
      show running-config

      Current configuration:
      !
      ver 08.0.20aT7f3
      !
      stack unit 1
        module 1 icx6610-48p-poe-port-management-module
        module 2 icx6610-qsfp-10-port-160g-module
        module 3 icx6610-8-port-10g-dual-mode-module
        stack-trunk 1/2/1 to 1/2/2
        stack-trunk 1/2/6 to 1/2/7
      !
      global-stp
      !
      !
      !
      vlan 1 name DEFAULT-VLAN by port
       spanning-tree
      !
      vlan 4 by port
      !
      vlan 99 name MGT by port
       tagged ethe 1/3/1
       router-interface ve 99
      !
      vlan 127 name ONT_MGT by port
       tagged ethe 1/3/2
       untagged ethe 1/1/48
       router-interface ve 127
      !
      vlan 400 name ONT_DATA by port
       tagged ethe 1/3/2
       untagged ethe 1/1/1
       router-interface ve 400
      !
      !
      !
      !
      !
      aaa authentication enable default local
      aaa authentication login default local
      jumbo
      enable acl-per-port-per-vlan
      hostname ICX6610-48P
      ip dhcp snooping vlan 127
      ip dhcp snooping vlan 400
      ip dns domain-list sniper.org
      ip dns server-address 8.8.8.8
      ip route 0.0.0.0/0 192.168.99.254
      !
      username admin password .....
      password-change any
      snmp-server community ..... ro
      snmp-server community ..... rw
      snmp-server community ..... rw
      snmp-server contact Goat
      snmp-server location BasementLab
      !
      !
      clock timezone us Central
      !
      !
      !
      !
      !
      !
      !
      interface loopback 1
      !
      interface ethernet 1/1/1
       port-name ComtrendRouter
       dhcp snooping relay information subscriber-id "BasementStack/1/1/1"
       rate-limit input fixed 3000
       rate-limit output shaping 24998
      !
      interface ethernet 1/1/2
       disable
       rate-limit input fixed 3000
       rate-limit output shaping 24998
      !
      interface ethernet 1/1/3
       disable
       rate-limit input fixed 3000
       rate-limit output shaping 24998
      !
      interface ethernet 1/1/4
       disable
       rate-limit input fixed 3000
       rate-limit output shaping 24998
      !
      interface ethernet 1/1/5
       disable
       rate-limit input fixed 3000
       rate-limit output shaping 24998
      !
      interface ethernet 1/1/6
       disable
       rate-limit input fixed 3000
       rate-limit output shaping 24998
      !
      interface ethernet 1/1/7
       disable
       rate-limit input fixed 3000
       rate-limit output shaping 24998
      !
      interface ethernet 1/1/8
       disable
       rate-limit input fixed 8000
       rate-limit output shaping 27994
      !
      interface ethernet 1/1/9
       disable
       rate-limit input fixed 2000
       rate-limit output shaping 9998
      !
      interface ethernet 1/1/10
       disable
       rate-limit input fixed 10000
       rate-limit output shaping 9998
      !
      interface ethernet 1/1/11
       disable
       rate-limit input fixed 2000
       rate-limit output shaping 9998
      !
      interface ethernet 1/1/12
       disable
      !
      interface ethernet 1/1/13
       disable
       rate-limit input fixed 3000
       rate-limit output shaping 24998
      !
      interface ethernet 1/1/14
       disable
      !
      interface ethernet 1/1/15
       disable
      !
      interface ethernet 1/1/16
       disable
      !
      interface ethernet 1/1/17
       disable
      !
      interface ethernet 1/1/18
       disable
      !
      interface ethernet 1/1/19
       disable
      !
      interface ethernet 1/1/20
       disable
      !
      interface ethernet 1/1/21
       disable
      !
      interface ethernet 1/1/22
       disable
      !
      interface ethernet 1/1/23
       disable
       rate-limit input fixed 50000
       rate-limit output shaping 49996
      !
      interface ethernet 1/1/24
       disable
      !
      interface ethernet 1/1/25
       disable
      !
      interface ethernet 1/1/26
       disable
      !
      interface ethernet 1/1/27
       disable
      !
      interface ethernet 1/1/28
       disable
      !
      interface ethernet 1/1/29
       disable
      !
      interface ethernet 1/1/30
       disable
      !
      interface ethernet 1/1/31
       disable
      !
      interface ethernet 1/1/32
       disable
      !
      interface ethernet 1/1/33
       disable
      !
      interface ethernet 1/1/34
       disable
      !
      interface ethernet 1/1/35
       disable
      !
      interface ethernet 1/1/36
       disable
      !
      interface ethernet 1/1/37
       disable
      !
      interface ethernet 1/1/38
       disable
      !
      interface ethernet 1/1/39
       disable
      !
      interface ethernet 1/1/40
       disable
      !
      interface ethernet 1/1/41
       disable
      !
      interface ethernet 1/1/42
       disable
      !
      interface ethernet 1/1/43
       disable
      !
      interface ethernet 1/1/44
       disable
      !
      interface ethernet 1/1/45
       disable
      !
      interface ethernet 1/1/46
       disable
      !
      interface ethernet 1/1/47
       disable
      !
      interface ethernet 1/1/48
       disable
      !
      interface ethernet 1/3/1
       port-name UPLINK
       dhcp snooping trust
      !
      interface ethernet 1/3/2
       port-name ONT1
       dhcp snooping relay information subscriber-id "basementstack/1/1/1"
       rate-limit input fixed 8000
       rate-limit output shaping 7999
      !
      interface ethernet 1/3/3
       port-name ONT2
       dhcp snooping relay information subscriber-id "icxstack1/1/1/2"
      !
      interface ve 99
       ip address 192.168.99.1 255.255.255.0
      !
      interface ve 127
       ip address 192.168.127.254 255.255.255.0
       ip address 192.168.128.254 255.255.255.0
       ip helper-address 1 10.200.200.1
      !
      interface ve 400
       ip address 10.0.25.254 255.255.255.0
       ip address 192.168.4.126 255.255.255.128
       ip helper-address 1 10.200.200.1
      !
      !
      !
      !
      sflow enable
      !
      !
      !
      !
      !
      end

      SSH@ICX6610-48P#
    FAKE_CONFIG
  end
end
