class CreateBillingCategories < ActiveRecord::Migration
  def self.up
    create_table :billing_categories do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :billing_categories
  end
end
