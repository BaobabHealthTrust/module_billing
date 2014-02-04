class BillingProductType < ActiveRecord::Base
	set_table_name :billing_product_type
  set_primary_key :product_type_id
  include Openmrs

  has_many :billing_products
end
