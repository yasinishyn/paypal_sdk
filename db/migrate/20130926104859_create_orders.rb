class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string  :name
      t.decimal :total
      t.integer :payerID 
      t.string  :code
      t.text    :token
      t.text    :payment_token

      t.timestamps
    end
  end
end
