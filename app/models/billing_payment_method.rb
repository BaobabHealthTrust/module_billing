class BillingPaymentMethod < ActiveRecord::Base
  set_table_name :billing_payment_method
  set_primary_key :payment_method_id
  include Openmrs
end
