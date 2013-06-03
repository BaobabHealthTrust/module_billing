class BillingMedicalSchemeProvidersController < ApplicationController
  def index
    @destination = "/clinic?user_id=#{params[:user_id]}"
		@medical_scheme_providers = BillingMedicalSchemeProvider.all
  end

  def new
    @medical_scheme_provider = BillingMedicalSchemeProvider.new
  end

  def edit
  end

  def create
    @medical_scheme_provider = BillingMedicalSchemeProvider.
                               create(:company_name => params[:company_name],
                                      :email_address => params[:email_address],
                                      :company_address => params[:company_address],
                                      :phone_number_1 => params[:phone_number_1],
                                      :phone_number_2 => params[:phone_number_2],
                                      :creator  => params[:user_id])
                                    
   redirect_to "/show_medical_scheme_providers?#{params[:user_id]}" if !params[:user_id].blank?
  end

  def update
  end

  def delete
  end

end
