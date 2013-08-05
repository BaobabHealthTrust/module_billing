class BillingSchemeProviderType < ActiveRecord::Base
  set_table_name :billing_scheme_provider_type
  set_primary_key :provider_type_id
  include Openmrs
end
