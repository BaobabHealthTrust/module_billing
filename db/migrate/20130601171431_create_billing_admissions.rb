class CreateBillingAdmissions < ActiveRecord::Migration
  def self.up
    create_table :billing_admissions do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :billing_admissions
  end
end
