class BillingCartController < ApplicationController
  
  def add_to_cart
    product = BillingProduct.find_by_name(params[:product])
    price_type = BillingAccount.find_by_patient_id(params[:patient_id]).price_type
    @vat = YAML.load_file("#{Rails.root}/config/application.yml")["#{Rails.env
        }"]["VAT"] rescue nil

    @cart = find_cart
    @cart.add_product(product,price_type)
  end

  def checkout
    
    @cart = find_cart

    unless @cart.nil?
      @billing_invoice = BillingInvoice.new
      @billing_invoice.account_id = 6
      @billing_invoice.invoice_type = "I"
      @billing_invoice.payment_method = "Medical Scheme"
      @billing_invoice.location_id = 721
      @billing_invoice.creator = 1
      @billing_invoice.total_amount = 0
      @billing_invoice.save!
      @invoice_total_amount = 0
      for item in @cart.items
        @billing_invoice_line = BillingInvoiceLine.new
        @billing_invoice_line.invoice_id = @billing_invoice.invoice_id
        @billing_invoice_line.product_id = item.product_code
        @billing_invoice_line.price_id  = 0
        @billing_invoice_line.quantity = item.quantity
        @billing_invoice_line.price_per_unit = item.price / item.quantity
        @billing_invoice_line.discount_amount = 0
        @billing_invoice_line.final_amount =  (@billing_invoice_line.quantity * @billing_invoice_line.price_per_unit) - @billing_invoice_line.discount_amount
        @billing_invoice_line.save!
        @invoice_total_amount += @billing_invoice_line.final_amount
      end
     @billing_invoice.total_amount = @invoice_total_amount
     @billing_invoice.save!
    else

    end
  end

  def remove_from_cart
  end

  def empty_cart
  end
  
  private

  def find_cart
    session[:cart] ||= Cart.new
  end

end
