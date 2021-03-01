json.extract! subnet, :id, :name, :network_address, :cidr, :shared_network_id, :created_at, :updated_at
json.url subnet_url(subnet, format: :json)
