class BillingAccountsMedicalSchemes < ActiveRecord::Base
	set_table_name :billing_account_medical_schemes
  include Openmrs

  has_and_belongs_to_many :billing_accounts
	has_and_belongs_to_many :medical_schemes
end
