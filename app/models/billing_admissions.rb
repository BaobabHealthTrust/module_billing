class BillingAdmissions < ActiveRecord::Base
	set_table_name :billing_admissions
  set_primary_key :admissions_id
  include Openmrs

  belongs_to :invoice_line, :foreign_key => :invoice_line_id
  belongs_to :billing_price, :foreign_key => :price_id
end
