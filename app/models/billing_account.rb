class BillingAccount < ActiveRecord::Base
	set_table_name :billing_account
  set_primary_key :account_id
  include Openmrs

  belongs_to :patient, :foreign_key => :patient_id

end
