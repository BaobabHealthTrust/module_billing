class BillingAccountsController < ApplicationController
  def index

  end

  def account_setting
      @patient = Patient.find(params[:patient_id])
  	  @account = BillingAccount.find_all_by_patient_id(@patient.id)
      render :layout => false
  end
  
  def invoice_history
      @patient = Patient.find(params[:patient_id])
  	  @account = BillingAccount.find_by_patient_id(@patient.id) 
	    @invoices = BillingInvoice.find_all_by_account_id(@patient.id)
      @invoices.each do |invoice|
        invoice.billing_invoice_lines.to_yaml do |inv|
          raise inv.inspect
        end
      end
	    
      render :layout => false
  end
  
  def show
  end

  def show_account_medical_scheme
  	@account = BillingAccount.find(params[:account_id])
	  scheme_ids = BillingAccountsMedicalSchemes.find_all_by_account_id(@account.account_id).map { |account_scheme| [account_scheme.medical_scheme_id]}      
	  
	  @medical_schemes = []
	  scheme_ids.each do |scheme_id|
	  	@medical_schemes << BillingMedicalScheme.find_by_medical_scheme_id(scheme_id)
	  end
# 	  @medical_schemes = BillingMedicalScheme.find_all_by_medical_scheme_id(scheme_ids.first)
  end

  def show_account_company_agreement
  	  @account = BillingAccount.find(params[:account_id])
	  scheme_ids = BillingAccountsMedicalSchemes.find_all_by_account_id(@account.account_id).map { |account_scheme| [account_scheme.medical_scheme_id]}      
	  
	  @medical_schemes = []
	  scheme_ids.each do |scheme_id|
	  	@medical_schemes << BillingMedicalScheme.find_by_medical_scheme_id(scheme_id)
	  end
# 	  @medical_schemes = BillingMedicalScheme.find_all_by_medical_scheme_id(scheme_ids.first)
  end


  def new
    @patient_id = params[:patient_id]
    @user_id = params[:user_id]
    @location_id = params[:location_id]
    @payment_methods_map = YAML.load_file("#{Rails.root}/config/application.yml")["#{Rails.env
        }"]["payment.methods"].split(",") rescue []

    @price_type_map = YAML.load_file("#{Rails.root}/config/application.yml")["#{Rails.env
        }"]["price.types"].split(",") rescue []



    @medical_schemes_map = BillingMedicalScheme.find_by_sql("SELECT * FROM billing_medical_scheme as ms
                                                             INNER JOIN billing_medical_scheme_provider as msp
                                                             ON msp.medical_scheme_provider_id = ms.medical_scheme_provider_id
                                                             WHERE (msp.provider_type = 'Provider' AND msp.voided = 0 AND ms.voided = 0);").each.map do |medical_scheme|
      [medical_scheme.company_name + "-" + medical_scheme.name,medical_scheme.medical_scheme_id]
                                                              end
    
    

    @company_schemes_map = BillingMedicalScheme.find_by_sql("SELECT * FROM billing_medical_scheme as ms
                                                             INNER JOIN billing_medical_scheme_provider as msp
                                                             ON msp.medical_scheme_provider_id = ms.medical_scheme_provider_id
                                                             WHERE (msp.provider_type = 'Company' AND msp.voided = 0 AND ms.voided = 0);").each.map do |medical_scheme|
      [medical_scheme.company_name + "-" + medical_scheme.name,medical_scheme.medical_scheme_id]
                                                              end

    @clinic_schemes_map = BillingMedicalScheme.find_by_sql("SELECT * FROM billing_medical_scheme as ms
                                                             INNER JOIN billing_medical_scheme_provider as msp
                                                             ON msp.medical_scheme_provider_id = ms.medical_scheme_provider_id
                                                             WHERE (msp.provider_type = 'Clinic' AND msp.voided = 0 AND ms.voided = 0);").each.map do |medical_scheme|
      [medical_scheme.company_name + "-" + medical_scheme.name,medical_scheme.medical_scheme_id]
                                                              end

    @referral_schemes_map = BillingMedicalScheme.find_by_sql("SELECT * FROM billing_medical_scheme as ms
                                                             INNER JOIN billing_medical_scheme_provider as msp
                                                             ON msp.medical_scheme_provider_id = ms.medical_scheme_provider_id
                                                             WHERE (msp.provider_type = 'Hospital' AND msp.voided = 0 AND ms.voided = 0);").each.map do |medical_scheme|
      [medical_scheme.company_name + "-" + medical_scheme.name,medical_scheme.medical_scheme_id]
                                                              end
    
  end

  def create
    @billing_account = BillingAccount.new()
    @billing_account.patient_id = params[:patient_id]
    @billing_account.creator = params[:user_id]
    @billing_account.payment_method = params[:payment_method]
    @billing_account.price_type = params[:price_type]
    @billing_account.save!

   case params[:payment_method].upcase
   when 'MEDICAL SCHEME','COMPANY AGREEMENT','GOVERNMENT REFERRAL','PRIVATE CLINIC REFERRAL'
     @account_medical_scheme = BillingAccountsMedicalSchemes.new
     @account_medical_scheme.medical_scheme_id = params[:medical_scheme]
     @account_medical_scheme.account_id = @billing_account.account_id
     @account_medical_scheme.save!
   end
    redirect_to "/patients/show/#{params[:patient_id]}?user_id=#{params[:user_id]}&location_id=#{params[:location_id]}" if !params[:patient_id].nil?
  end

end