class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :receiver_email
      t.string :notify_version
      t.string :transaction_id
      t.string :parent_txn_id
      t.string :receipt_id
      t.string :receiver_email
      t.string :receiver_id
      t.string :resend
      t.string :residence_country
      t.string :test_ipn
      t.string :txn_type
      t.string :verify_sign

      t.timestamps
    end
  end
end
