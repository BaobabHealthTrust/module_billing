class BillingAccountsMedicalSchemes < ActiveRecord::Base
	set_table_name :billing_accounts_medical_schemes
  include Openmrs

#   belongs_to :billing_account
#   belongs_to :billing_medical_scheme
end
