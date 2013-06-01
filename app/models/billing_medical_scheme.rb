class BillingMedicalScheme < ActiveRecord::Base
	set_table_name :billing_medical_scheme
  set_primary_key :medical_scheme_id
  include Openmrs

  belongs_to :billing_medical_scheme_provider, :foreign_key => :medical_scheme_provide_id
  has_many :billing_rules
end
