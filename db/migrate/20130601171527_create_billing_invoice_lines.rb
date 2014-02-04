class CreateBillingInvoiceLines < ActiveRecord::Migration
  def self.up
    create_table :billing_invoice_lines do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :billing_invoice_lines
  end
end
