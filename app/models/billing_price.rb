class BillingPrice < ActiveRecord::Base
	set_table_name :billing_price
  set_primary_key :price_id
  include Openmrs

  belongs_to :billing_service, :foreign_key => :service_id
	belongs_to :drug, :foreign_key => :drug_id
  has_many :billing_invoice_lines
end
