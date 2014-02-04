class BillingDepartment < ActiveRecord::Base
	set_table_name :billing_department
  set_primary_key :department_id
  include Openmrs

  has_many :billing_categories , :foreign_key => :department_id
end
