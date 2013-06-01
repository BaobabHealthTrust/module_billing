class BillingMedicalSchemeProvider < ActiveRecord::Base
	set_table_name :billing_medical_scheme_provider
  set_primary_key :medical_scheme_provider_id
  include Openmrs

  belongs_to :billing_account, :foreign_key => :account_id
  has_many :billing_medical_schemes
end
