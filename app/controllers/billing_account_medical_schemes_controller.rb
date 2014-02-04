class BillingAccountMedicalSchemesController < ApplicationController

  def new
	  @medical_schemes_map = BillingMedicalScheme.all.map{ |medical_scheme| [BillingMedicalSchemeProvider.find_by_medical_scheme_provider_id(medical_scheme.medical_scheme_id).company_name + " - "+ medical_scheme.name, medical_scheme.medical_scheme_id] }

  end

  def create
		@account_medical_scheme = BillingAccountsMedicalSchemes.new
    @account_medical_scheme.medical_scheme_id = params[:medical_scheme_id]
    @account_medical_scheme.account_id = params[:account_id]
    @redirect_url = "/show_account_medical_scheme?account_id=#{params[:account_id]}&user_id=#{params[:user_id]}" if !params[:user_id].blank? 
	 respond_to do |format|
      		if @account_medical_scheme.save
        		format.html { redirect_to "/show_account_medical_scheme?account_id=#{params[:account_id]}&user_id=#{params[:user_id]}" if !params[:user_id].blank? }
        		format.xml  { render :xml => @account_medical_scheme, :status => :created, :location => @account_medical_scheme }
      		else
        		format.html { render :action => "new" }
        		format.xml  { render :xml => @account_medical_scheme.errors, :status => :unprocessable_entity }
      		end
      	end
  end

  def update
  end

  def destroy
  end

end
