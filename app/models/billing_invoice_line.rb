class BillingInvoiceLine < ActiveRecord::Base
	set_table_name :billing_invoice_line
  set_primary_key :invoice_line_id
  include Openmrs

  belongs_to :billing_invoice, :foreign_key => :invoice_id
	belongs_to :billing_product, :foreign_key =>  :product_id
end
