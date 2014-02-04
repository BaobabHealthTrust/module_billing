class CreateBillingProductTypes < ActiveRecord::Migration
  def self.up
    create_table :billing_product_types do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :billing_product_types
  end
end
