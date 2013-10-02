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

    #@destination = "/invoice_summary?patient_id=#{@patient_id}&user_id=#{params[:user_id]}"
    @destination = "/payment_method?patient_id=#{@patient_id}&user_id=#{params[:user_id]}"
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
      @billing_invoice.location_id = 1
      @billing_invoice.creator = params[:user_id]
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
     @billing_invoice.tendered_amount = params[:tendered_amount].to_f
     @billing_invoice.change_amount = @billing_invoice.tendered_amount - @billing_invoice.total_amount
     @billing_invoice.paid = true if @billing_invoice.invoice_type == "C"
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
    @tendered_amount = params[:tendered_amount]
    @cart = find_cart
    @vat = YAML.load_file("#{Rails.root}/config/application.yml")["#{Rails.env
      }"]["VAT"] rescue nil
    @destination = "/checkout?patient_id=#{params[:patient_id]}&user_id=#{params[:user_id]}&tendered_amount=#{params[:tendered_amount]}"
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
    
    application_config = YAML.load_file("#{Rails.root}/config/application.yml")["#{Rails.env
      }"] rescue nil
    # Fonts
    title_header_font = {:font_reverse => false,:font_size => 4, :font_horizontal_multiplier => 1, :font_vertical_multiplier => 1 }
    normal_font = {:font_reverse => false, :font_size => 3, :font_horizontal_multiplier => 1, :font_vertical_multiplier => 1 }
    #title_font_top_bottom = {:font_reverse => false, :font_size => 4, :font_horizontal_multiplier => 1, :font_vertical_multiplier => 1, :left_margin => 100}
    title_font_bottom = {:font_reverse => false, :font_size => 2, :font_horizontal_multiplier => 1, :font_vertical_multiplier => 1}

    # Headers
    facility_name = application_config["facility.name"] rescue " "
    facility_address = application_config["facility.address"] rescue " "
    facility_telephone = application_config["facility.telephone"] rescue " "
    facility_url = application_config["facility.url"] rescue " "
    
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
    received_amount = invoice.tendered_amount
    change_amount = invoice.change_amount
    
    vat = application_config["VAT"] rescue 1.0
    tax = (total_amount * vat) / 100
    sub_total = total_amount - tax

    invoice_lines = invoice.billing_invoice_lines
    
    receipt = ZebraPrinter::Receipt.new
    receipt.font_size = 4
    receipt.x = 140
    receipt.font_horizontal_multiplier = 1
    receipt.font_vertical_multiplier = 1
    receipt.left_margin = 100
    #receipt.draw_barcode(100,400,0,1,5,15,90,false,"#{invoice_number}")
    #draw_text(text, @x, @y, 0, @font_size, @font_horizontal_multiplier, @font_vertical_multiplier, @font_reverse)
    # draw logo
    receipt.draw_image(140,10)

    # facility information
    receipt.draw_text(facility_name,260,30,0,4)
    receipt.draw_text(facility_address, 260,68,0,3)
    receipt.draw_text(facility_telephone, 260,98,0,3)
    receipt.draw_text(facility_url, 260,128,0,3)

    # receipt information
    receipt.draw_text("Receipt No.", 140,208,0,3)
    receipt.draw_text("#{ receipt_number}",350,208  ,0,3)
    receipt.draw_line(350,228,300,2)


     # receipt date information
    receipt.draw_text("Invoice Date", 140,248,0,3)
    receipt.draw_text("#{invoice_date.strftime('%d %b %Y')}",350,248  ,0,3)
    receipt.draw_line(350,268,300,2)

      # patient name
    receipt.draw_text("Name", 140,288,0,3)
    receipt.draw_text("#{patient_name.titleize}",350,288 ,0,3)
    receipt.draw_line(350,308,300,2)


      # patient gender
    receipt.draw_text("Gender", 140,328,0,3)
    receipt.draw_text("#{patient_gender == "F" ? "Female" : "Male" }",350,328 ,0,3)
    receipt.draw_line(350,348,300,2)


      # patient age
    receipt.draw_text("Age", 140,368,0,3)
    receipt.draw_text("#{patient_age}",350,368,0,3)
    receipt.draw_line(350,388,300,2)

     # upper line
    receipt.draw_text("-" * 41, 140, 420, 0, 3)
    receipt.draw_text("INVOICE", 360, 450, 0, 4)
    receipt.draw_text("-" * 41, 140, 480, 0, 3)

    # item header
    receipt.draw_text("SRVC NO.", 140, 520, 0, 3)
    receipt.draw_text("DEPT.", 260, 520, 0, 3)
    receipt.draw_text("Description", 360, 520, 0, 3)
    receipt.draw_text("Amount", 580, 520, 0, 3)
    receipt.draw_line(140,540,570,2)

    # invoice lines
    y = 560
    invoice_lines.each do |invoice_line|
        receipt.draw_text("##{invoice_line.invoice_line_id}", 140, y, 0, 3)
        receipt.draw_text("#{invoice_line.billing_product.billing_category.billing_department.name.upcase[0..2]}", 260, y, 0, 3)
        receipt.draw_text("#{invoice_line.billing_product.name}", 360, y, 0, 3)
        receipt.draw_text("#{sprintf('%.2f', invoice_line.final_amount)}", 580, y, 0, 3)
        y += 40
    end
    receipt.draw_line(140,y,570,2)

    y += 40
    receipt.draw_text("Subtotal", 360, y, 0, 3)
    receipt.draw_text("#{sprintf('%.2f',sub_total)}", 580, y, 0, 3)

    y += 40
    receipt.draw_text("Tax", 360, y, 0, 3)
    receipt.draw_text("#{sprintf('%.2f',tax)}", 580, y, 0, 3)
    
    y += 40
    receipt.draw_text("TOTAL", 360, y, 0, 4)
    receipt.draw_text("#{sprintf('%.2f',total_amount)}", 580, y, 0, 4)

    y += 60
    receipt.draw_text("Received", 360, y, 0, 3)
    receipt.draw_text("#{sprintf('%.2f',received_amount)}", 580, y, 0, 3)

    y += 40
    receipt.draw_text("Change", 360, y, 0, 3)
    receipt.draw_text("#{sprintf('%.2f',change_amount)}", 580, y, 0, 3)

    y += 80
    receipt.draw_barcode(250,y,0,1,5,15,80,true,"#{receipt_number}")
    
    receipt.print(1)
  end

  def payment_method
    @payment_methods = ["Cash","Cheque","Invoice"]
    @patient_id = params[:patient_id]
    @user_id = params[:user_id]
  end

  def payment_amount
    @cart = find_cart
    unless @cart.nil?
      @invoice_total_amount = 0
      for item in @cart.items
        @billing_invoice_line = BillingInvoiceLine.new
        @billing_invoice_line.discount_amount = 0
        @billing_invoice_line.price_per_unit = item.price / item.quantity
        @billing_invoice_line.final_amount =  (item.quantity * @billing_invoice_line.price_per_unit) - @billing_invoice_line.discount_amount
        @invoice_total_amount += @billing_invoice_line.final_amount
      end
     @invoice_total_amount
    end

    if params[:payment_method].upcase == "CASH"
      @total_amount =  ""
    else
      @total_amount =  @invoice_total_amount
    end
  end

  private

  def find_cart
    session[:cart] ||= Cart.new
  end

end
