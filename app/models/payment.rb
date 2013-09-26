class Payment < ActiveRecord::Base
  attr_accessible :notify_version, :parent_txn_id, :receipt_id, :receiver_email, :receiver_email, :receiver_id, :resend, :residence_country, :test_ipn, :transaction_id, :txn_type, :verify_sign
end
