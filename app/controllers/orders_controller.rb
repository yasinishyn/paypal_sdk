class OrdersController < ApplicationController
  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])
    @paypal = PaypalInterface.new(@order)
    @paypal.express_checkout
    if @paypal.express_checkout_response.success?
      @paypal_url = @paypal.api.express_checkout_url(@paypal.express_checkout_response)
    else
      flash[:error] = @paypal.express_checkout_response.errors[0].send :ShortMessage 
      flash[:error2] = @paypal.express_checkout_response.errors[0].send :LongMessage
      flash[:error3] = @paypal.express_checkout_response.errors[0].send :ErrorCode
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(params[:order])

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render json: @order, status: :created, location: @order }
      else
        format.html { render action: "new" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  def paid
    if order = Order.pay(params[:token], params[:PayerID])
      # success message
    else
      # error message
    end
    redirect_to orders_path
  end

  def revoked
    if order = Order.cancel_payment(params)
      # set a message for the user
    end
    redirect_to orders_path
  end

  def ipn
    if payment = Payment.find_by_transaction_id(params[:txn_id])
      payment.receive_ipn(params)
    else
      Payment.create_by_ipn(params)
    end
  end

end
