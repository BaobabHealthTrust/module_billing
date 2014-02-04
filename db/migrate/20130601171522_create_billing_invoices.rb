class CreateBillingInvoices < ActiveRecord::Migration
  def self.up
    create_table :billing_invoices do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :billing_invoices
  end
end
