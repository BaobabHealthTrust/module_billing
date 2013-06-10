class BillingMedicalScheme < ActiveRecord::Base
	set_table_name :billing_medical_scheme
  set_primary_key :medical_scheme_id
  include Openmrs

  belongs_to :billing_medical_scheme_provider, :foreign_key => :medical_scheme_provider_id
  has_many :billing_rules
  has_and_belongs_to_many :billing_accounts
end
