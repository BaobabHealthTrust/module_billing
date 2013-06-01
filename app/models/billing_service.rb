class BillingService < ActiveRecord::Base
	set_table_name :billing_service
  set_primary_key :service_id
  include Openmrs

  belongs_to :billing_category, :foreign_key => :category_id
  has_many :billing_products, :through => :service_id
end
