class BillingCategory < ActiveRecord::Base
	set_table_name :billing_category
  set_primary_key :category_id
  include Openmrs

  belongs_to :billing_department , :foreign_key => :department_id
  has_many :billing_services
end
