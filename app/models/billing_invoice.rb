class BillingInvoice < ActiveRecord::Base
	set_table_name :billing_invoice
  set_primary_key :invoice_id
  include Openmrs

  belongs_to :billing_account, :foreign_key => :account_id
	belongs_to :location, :foreign_key => :location_id
  has_many :billing_invoice_lines
end
