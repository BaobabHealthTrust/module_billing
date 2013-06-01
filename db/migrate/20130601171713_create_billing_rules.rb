class CreateBillingRules < ActiveRecord::Migration
  def self.up
    create_table :billing_rules do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :billing_rules
  end
end
