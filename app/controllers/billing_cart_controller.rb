class BillingCartController < ApplicationController
  
  def add_to_cart
    
    @vat = YAML.load_file("#{Rails.root}/config/application.yml")["#{Rails.env
      }"]["VAT"] rescue nil
    @cart = find_cart
    @location_id = session[:location_id]
    @patient_id = params[:patient_id]
    @patient = Patient.find(params[:id] || params[:patient_id]) rescue nil
   
    if params[:product]
      product = BillingProduct.find_by_name(params[:product])
      price_type = BillingAccount.find_by_patient_id(@patient_id).price_type
      @cart.add_product(product,price_type)
    end

    @department_id = nil

    if params[:department_id]
      @department_id = BillingDepartment.find(params[:department_id]).department_id
    end

    render :layout => true

  end

  def checkout
    @cart = find_cart
    @patient = Patient.find(params[:patient_id])
    @account = @patient.billing_account
    unless @cart.nil?
      @billing_invoice = BillingInvoice.new
      @billing_invoice.account_id = @account.account_id
      @billing_invoice.invoice_type = @account.payment_method.upcase == "CASH" ? "C" : "I"
      @billing_invoice.payment_method = @account.payment_method
      @billing_invoice.location_id = params[:location_id]
      @billing_invoice.creator = params[:user_id]
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
     session[:cart] = nil
     redirect_to "/clinic?user_id=#{params[:user_id]}&location_id=#{params[:location_id]}"
    else

    end
  end

  def remove_from_cart
    a = BillingProduct.find(params[:target_id])
    @cart = find_cart
    @cart.remove_product(a)

    if @cart.items.length == 0
       redirect_to "/patients/show?patient_id=#{params[:patient_id]}&location_id=#{params[:location_id]}&user_id=#{params[:user_id]}"
    else
       redirect_to "/add_to_cart?patient_id=#{params[:patient_id]}&location_id=#{params[:location_id]}&user_id=#{params[:user_id]}"
    end
  end

  def empty_cart
  end
  
  private

  def find_cart
    session[:cart] ||= Cart.new
  end

end
