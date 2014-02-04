class CreateBillingDepartments < ActiveRecord::Migration
  def self.up
    create_table :billing_departments do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :billing_departments
  end
end
