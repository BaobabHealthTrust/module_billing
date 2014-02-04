class CreateBillingProducts < ActiveRecord::Migration
  def self.up
    create_table :billing_products do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :billing_products
  end
end
