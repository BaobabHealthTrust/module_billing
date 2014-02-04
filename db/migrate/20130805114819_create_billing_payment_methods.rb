class CreateBillingPaymentMethods < ActiveRecord::Migration
  def self.up
    create_table :billing_payment_method do |t|
      t.string :name
      t.bolean :voided

      t.timestamps
    end
  end

  def self.down
    drop_table :billing_payment_method
  end
end
