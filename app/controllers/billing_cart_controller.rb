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
    elsif !params[:product_id].blank? && !params[:admitted_date].blank? && !params[:discharge_date].blank?
      product = BillingProduct.find(params[:product_id])
      price_type = BillingAccount.find_by_patient_id(@patient_id).price_type
      quantity = params[:discharge_date].to_date.day - params[:admitted_date].to_date.day
      quantity = quantity <= 0 ? 1 : quantity
      quantity.times do
        @cart.add_product(product,price_type)
      end
    elsif !params[:product_id].blank?
      product = BillingProduct.find(params[:product_id])
      price_type = BillingAccount.find_by_patient_id(@patient_id).price_type
      params[:quantity].to_i.times do
        @cart.add_product(product,price_type)
      end
    end

    @department_id = nil
    @department_name = nil

    if params[:department_id]
      department = BillingDepartment.find(params[:department_id])
      @department_id = department.department_id
      @department_name = department.name
    end

    @category_id = nil
    
    if params[:category_id]
      @category_id = BillingCategory.find(params[:category_id]).category_id
    end

    @destination = "/invoice_summary?patient_id=#{@patient_id}&user_id=#{params[:user_id]}"

    render :layout => true

  end

  def add_to_cart2
    
    #raise params.to_yaml

    @vat = YAML.load_file("#{Rails.root}/config/application.yml")["#{Rails.env
      }"]["VAT"] rescue nil
    @cart = find_cart
    @location_id = session[:location_id]
    @patient_id = params[:patient_id]
    @patient = Patient.find(params[:id] || params[:patient_id]) rescue nil


    @departments = BillingDepartment.all.map do |department|
      [department.name, department.department_id]
    end



    if params[:product]
      product = BillingProduct.find_by_name(params[:product])
      price_type = BillingAccount.find_by_patient_id(@patient_id).price_type
      @cart.add_product(product,price_type)
    elsif params[:product_id]
      product = BillingProduct.find(params[:product_id])
      price_type = BillingAccount.find_by_patient_id(@patient_id).price_type
      params[:quantity].to_i.times do
        @cart.add_product(product,price_type)
      end
    end

    @department_id = nil
    @department_name = nil

    if params[:department_id]
      department = BillingDepartment.find(params[:department_id])
      @department_id = department.department_id
      @department_name = department.name
    end

    @category_id = nil

    if params[:category_id]
      @category_id = BillingCategory.find(params[:category_id]).category_id
    end

    @destination = "/invoice_summary?patient_id=#{@patient_id}&user_id=#{params[:user_id]}"

    render :layout => false

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
      @billing_invoice.location_id =
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
     
     print_and_redirect("/billing_cart/invoice_number?invoice_number=#{@billing_invoice.invoice_id}", "/clinic?user_id=#{params[:user_id]}&location_id=#{params[:location_id]}")
     
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

  def summary
    @cart = find_cart
    @vat = YAML.load_file("#{Rails.root}/config/application.yml")["#{Rails.env
      }"]["VAT"] rescue nil
    @destination = "/checkout?patient_id=#{params[:patient_id]}&user_id=#{params[:user_id]}"
   
  end

  def invoice_number
    print_string = receipt(params[:invoice_number])
    send_data(print_string,:type=>"application/label; charset=utf-8",:stream=> false,
      :filename=>"#{params[:invoice_number]}#{rand(10000)}.lbl",:disposition => "inline")
  end

  def receipt_print
    print_and_redirect("/billing_cart/invoice_number?invoice_number=#{params[:invoice_number]}", "/patients/show/#{params[:patient_id]}")
  end


  def receipt(invoice_number)
    invoice = BillingInvoice.find(invoice_number)
    receipt_number = invoice.invoice_id
    invoice_date = invoice.created_at
    account_id = invoice.account_id
    patient_id = BillingAccount.find_by_account_id(account_id).patient_id
    patient = Patient.find(patient_id)
    patient_name = patient.name
    patient_gender = patient.gender
    patient_age = patient.age > 0 ? patient.age : "#{patient.age_in_months} months"

    total_amount = invoice.total_amount
    vat = YAML.load_file("#{Rails.root}/config/application.yml")["#{Rails.env
      }"]["VAT"] rescue nil
    tax = (total_amount * vat) / 100
    sub_total = total_amount - tax


    invoice_lines = invoice.billing_invoice_lines
    
    label = ZebraPrinter::Receipt.new
    label.font_size = 4
    label.x = 130
    label.font_horizontal_multiplier = 1
    label.font_vertical_multiplier = 1
    label.left_margin = 100
    image = ChunkyPNG::Image.from_file("#{Rails.root}/public/images/daeyang.png")
    label.draw_image(image.dimension.width, image.dimension.height, image)
    #label.draw_barcode(100,400,0,1,5,15,90,false,"#{invoice_number}")
    label.draw_multi_text("Receipt No #{ receipt_number}")
    label.draw_multi_text("Invoice Date #{ invoice_date.strftime('%d %b %Y')}")
    label.draw_multi_text("Name #{ patient_name.titleize}")
    label.draw_multi_text("Gender #{ patient_gender}")
    label.draw_multi_text("Age #{ patient_age}")
    label.draw_multi_text("INVOICE")
    label.draw_multi_text("#SRVNO DEPARTMENT DESCRIPTION AMOUNT")
    invoice_lines.each do |invoice_line|
      label.draw_multi_text("#{invoice_line.invoice_line_id} #{invoice_line.billing_product.billing_category.billing_department.name.titleize} #{invoice_line.billing_product.name} #{invoice_line.final_amount}")
    end

    label.draw_multi_text("Subtotal #{ sub_total }")
    label.draw_multi_text("Tax #{ tax }")
    label.draw_multi_text("Total #{ total_amount }")
    
    label.print(1)
  end


  private

  def find_cart
    session[:cart] ||= Cart.new
  end

end
