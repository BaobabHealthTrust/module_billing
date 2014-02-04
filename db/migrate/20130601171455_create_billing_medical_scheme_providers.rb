class CreateBillingMedicalSchemeProviders < ActiveRecord::Migration
  def self.up
    create_table :billing_medical_scheme_providers do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :billing_medical_scheme_providers
  end
end
