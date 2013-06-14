class BillingAccountsController < ApplicationController
  def index
  end

  def account_setting
      @patient = Patient.find(params[:patient_id])
  	  @account = BillingAccount.find_by_patient_id(@patient.id) 
      render :layout => false
  end
  
  def invoice_history
      @patient = Patient.find(params[:patient_id])
  	  @account = BillingAccount.find_by_patient_id(@patient.id) 
	    @invoices = BillingInvoice.find_all_by_account_id(@account.account_id)
	    @invoicelines = BillingInvoiceLine.find_all_by_invoice_id(BillingInvoice.find_all_by_account_id(@account.account_id))
	  
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
    @medical_schemes_map = BillingMedicalScheme.all.map do |medical_scheme|
      [medical_scheme.billing_medical_scheme_provider.company_name + "-" + medical_scheme.name,medical_scheme.medical_scheme_id]
    end
  end

  def create
    
  end

  def update
  end

  def delete
  end

end