class AccessxController < ApplicationController
  def index
  end

  def customers
    @customers = AccessxCustomer.new
  end
end
