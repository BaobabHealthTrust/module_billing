class CreateBillingServices < ActiveRecord::Migration
  def self.up
    create_table :billing_services do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :billing_services
  end
end
