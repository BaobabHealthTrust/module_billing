class BillingRules < ActiveRecord::Base
	set_table_name :billing_rules
  set_primary_key :rule_id
  include Openmrs

  belongs_to :billing_medical_scheme, :foreign_key => :medical_scheme_id
  has_many :billing_invoice_lines
end
