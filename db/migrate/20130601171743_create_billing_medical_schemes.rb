class CreateBillingMedicalSchemes < ActiveRecord::Migration
  def self.up
    create_table :billing_medical_schemes do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :billing_medical_schemes
  end
end
