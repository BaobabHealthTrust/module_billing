class CreateBillingPrices < ActiveRecord::Migration
  def self.up
    create_table :billing_prices do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :billing_prices
  end
end
