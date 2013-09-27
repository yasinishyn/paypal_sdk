class Order < ActiveRecord::Base
  attr_accessible :total, :name

  def self.pay(token, payerID)
    begin
      order = self.find_by_payment_token(token)
      order.payerID = payerID
      order.save
      PaypalWorker.perform_async(order.id)
      return order
    rescue
      false
    end
  end

  def set_payment_token token 
    self.token = token
    save
  end
end
