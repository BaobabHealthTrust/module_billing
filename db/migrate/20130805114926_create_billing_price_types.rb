class CreateBillingPriceTypes < ActiveRecord::Migration
  def self.up
    create_table :billing_price_types do |t|
      t.string :name
      t.bolean :voided

      t.timestamps
    end
  end

  def self.down
    drop_table :billing_price_types
  end
end
