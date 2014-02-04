class BillingProduct < ActiveRecord::Base
	set_table_name :billing_product
  set_primary_key :product_id
  include Openmrs

	belongs_to :billing_category, :foreign_key => :category_id
  belongs_to :billing_product_type, :foreign_key => :product_type_id
  has_many :billing_prices, :foreign_key => :product_id
  has_many :billing_invoice_lines
end
