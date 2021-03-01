# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

# Customers, Locations, and Addresses
5.times do
  Customer.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    company_name: Faker::Company.name
  )
end

5.times do
  Customer.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
end

Customer.all.map do |customer|
  customer.create_address(
    address1: Faker::Address.street_address,
    address2: Faker::Address.secondary_address,
    city: Faker::Address.city,
    state: Faker::Address.state_abbr,
    postal_code: Faker::Address.postcode
  )
end

Customer.all.map do |customer|
  @location = customer.locations.create(name:'Default location')
  @location.create_address(
    address1: Faker::Address.street_address,
    address2: Faker::Address.secondary_address,
    city: Faker::Address.city,
    state: Faker::Address.state_abbr,
    postal_code: Faker::Address.postcode
  )
end

# ONTs
Ont.create(name: 'FTTx switch', manufacturer: 'Zhone', model: 'ZNID2424')
Ont.create(name: 'FTTx switch', manufacturer: 'Zhone', model: 'ZNID2426A')
Ont.create(name: 'FTTx switch', manufacturer: 'Zhone', model: 'ZNID2728A1')

# Switches, Slots, and Ports
@switch1 = Switch.create(name: 'CO Brocade', manufacturer: 'Brocade', model: 'ICX6610', management_ip: '192.168.99.1')
@switch2 = Switch.create(name: 'CO Fiber Switch', manufacturer: 'Arista', model: 'DCS-7050T-64-R', management_ip: '192.168.127.254')
@switch3 = Switch.create(name: 'Remote B Switch', manufacturer: 'Arista', model: '7800R3', management_ip: '172.16.12.1')

(1..24).map do |number|
  @switch1.ports.create(port_number: number, name: "1/1/#{number}", description: "description of port 1/1/#{number}")
end

(1..12).map do |number|
  @switch2.slots.create(slot_number: number, name: "Slot #{number}", description: "Description of slot #{number}")
end

@switch2.slots.map do |slot|
  (1..24).map do |number|
    slot.ports.create(port_number: number, name: "1/#{slot.slot_number}/#{number}", description: "description of port 1/#{slot.slot_number}/#{number}")
  end
end

(1..8).map do |number|
  @switch3.ports.create(port_number: number, name: "1/1/#{number}", description: "description of port 1/1/#{number}")
end

(1..4).map do |number|
  @switch3.slots.create(slot_number: number, name: "Slot #{number}", description: "Description of slot #{number}")
end

@switch3.slots.map do |slot|
  (1..12).map do |number|
    slot.ports.create(port_number: number, name: "1/#{slot.slot_number}/#{number}", description: "description of port 1/#{slot.slot_number}/#{number}")
  end
end

# Dhcp Servers, Shared Networks, Subnets, Pools, and IPs
@server = DhcpServer.create(name: 'Default Server', server_type: 'dnsmasq')
@management = @server.shared_networks.create(name: 'Management', relayed_from_ip: '192.168.127.254')
@management_subnet = @management.subnets.create(name: 'Subnet 1', network_address: '192.168.127.0', cidr: 24)
@management_pool = @management_subnet.pools.create(name: 'First pool', start_ip: '192.168.127.1', end_ip: '192.168.127.250')
(1..250).map do |number|
  @management_pool.ips.create(address: "192.168.127.#{number}")
end

@public = @server.shared_networks.create(name: 'Internet', relayed_from_ip: '74.115.103.254')
@public_subnet1 = @public.subnets.create(name: 'Subnet 1', network_address: '74.115.103.0', cidr: 24)
@public_pool1 = @public_subnet1.pools.create(name: 'Primary Pool', start_ip: '74.115.103.10', end_ip: '74.115.103.253')
(10..253).map do |number|
  @public_pool1.ips.create(address: "74.115.103.#{number}")
end
@public_subnet2 = @public.subnets.create(name: 'Subnet 2', network_address: '66.172.200.0', cidr: 25)
@public_pool2 = @public_subnet2.pools.create(name: 'Secondary Pool', start_ip: '66.172.200.1', end_ip: '66.172.200.125')
(1..125).map do |number|
  @public_pool2.ips.create(address: "66.172.200.#{number}")
end
