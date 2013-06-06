class BillingAccount < ActiveRecord::Base
	set_table_name :billing_account
  set_primary_key :account_id
  include Openmrs

  belongs_to :patient, :foreign_key => :patient_id
#   has_many :billing_account_medical_schemes
#   has_many :billing_medical_schemes, :through => :billing_account_medical_schemes
  has_and_belongs_to_many :billing_medical_schemes	
end
