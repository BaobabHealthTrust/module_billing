class CreateBillingAccounts < ActiveRecord::Migration
  def self.up
    create_table :billing_accounts do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :billing_accounts
  end
end
