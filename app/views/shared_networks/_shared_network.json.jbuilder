json.extract! shared_network, :id, :name, :relayed_from_ip, :dhcp_server_id, :created_at, :updated_at
json.url shared_network_url(shared_network, format: :json)
