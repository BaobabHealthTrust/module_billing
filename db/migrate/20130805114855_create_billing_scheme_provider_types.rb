class CreateBillingSchemeProviderTypes < ActiveRecord::Migration
  def self.up
    create_table :billing_scheme_provider_type do |t|
      t.string :name
      t.bolean :voided

      t.timestamps
    end
  end

  def self.down
    drop_table :billing_scheme_provider_type
  end
end
