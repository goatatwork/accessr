class StaticPagesController < ApplicationController
  def home
    get_some_stats
  end

  private
    def get_some_stats
      @some_stats = {
        number_of_customers: Customer.count,
        number_of_dhcp_servers: DhcpServer.count,
        number_of_ips: Ip.count,
        number_of_ports: Port.count,
        number_of_prs: ProvisioningRecord.count,
        number_of_switches: Switch.count,
      }
    end
end
