class BillingInvoiceController < ApplicationController
  def delete
    
      invoice = BillingInvoice.find(params[:target_id])
      invoice_lines = BillingInvoiceLine.find_all_by_invoice_id_and_voided(invoice.invoice_id, false)
      project = get_global_property_value("project.name") rescue "Unknown"
      user_id = params[:user_id]
      patient_id = params[:patient_id]
      void_time = Time.now
      void_message = "Voided through #{project}"

      invoice_lines.each do |invoice_line|
            invoice_line.void(void_message,void_time,user_id)
      end
      
      invoice.void(void_message,void_time,user_id)

      respond_to do |format|
        	format.html { redirect_to "/billing_accounts/invoice_history?patient_id=#{patient_id}&user_id=#{user_id}" }
      end
  end

  def show_invoice
    @invoice = BillingInvoice.find(params[:invoice_id])
    @vat = YAML.load_file("#{Rails.root}/config/application.yml")["#{Rails.env
      }"]["VAT"] rescue nil
    #@destination = "/checkout?patient_id=#{params[:patient_id]}&user_id=#{params[:user_id]}&tendered_amount=#{params[:tendered_amount]}&payment_method=#{params[:payment_method]}"
  end

end
