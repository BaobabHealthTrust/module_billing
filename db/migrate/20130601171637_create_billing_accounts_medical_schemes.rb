class CreateBillingAccountsMedicalSchemes < ActiveRecord::Migration
  def self.up
    create_table :billing_accounts_medical_schemes do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :billing_accounts_medical_schemes
  end
end
