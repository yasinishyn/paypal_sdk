require 'paypal-sdk-adaptivepayments'

class PaypalInterface
  attr_reader :api, :response, :error

  PAYPAL_RETURN_URL = Rails.application.routes.url_helpers.paid_orders_url(host: HOST_WO_HTTP)
  PAYPAL_CANCEL_URL = Rails.application.routes.url_helpers.revoked_orders_url(host: HOST_WO_HTTP)
  PAYPAL_NOTIFY_URL = Rails.application.routes.url_helpers.ipn_orders_url(host: HOST_WO_HTTP)

  def initialize(order)
    @api = PayPal::SDK::AdaptivePayments.new
    @order = order
  end

  def express_checkout
    @pay = @api.build_pay({
      :actionType         => "PAY",
      :cancelUrl          => PAYPAL_CANCEL_URL,
      :currencyCode       => "USD",
      :feesPayer          => "SENDER",
      :ipnNotificationUrl => PAYPAL_NOTIFY_URL,
      :receiverList       => {
                              :receiver => [{
                                              :amount => @order.amount,
                                              :email  => "yasinishyn.a.n@gmail.com" 
                                            }] 
                            },
      :returnUrl => PAYPAL_RETURN_URL
    })

    # Make API call & get response
    @response = @api.pay(@pay)
    # Access Response
    if @response.success?
      @response.payKey
      @api.payment_url(@response)  # Url to complete payment
    else
      @error = @response.error[0].message
    end
  end # def express_checkout

  
end