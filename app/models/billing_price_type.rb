class BillingPriceType < ActiveRecord::Base
  set_table_name :billing_price_type
  set_primary_key :price_type_id
  include Openmrs
end
