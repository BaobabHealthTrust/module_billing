class BillingMedicalSchemeProvidersController < ApplicationController
  def index
    @destination = "/clinic?user_id=#{params[:user_id]}"
		@medical_scheme_providers = BillingMedicalSchemeProvider.all
    
    if params[:user_id].nil?
			redirect_to '/encounters/no_user' and return
		end
		@user = User.find(params[:user_id]) rescue nil?

    respond_to do |format|
      		format.html # new.html.erb
      		format.xml  { render :xml => @medical_scheme_providers }
    end
    
  end

  def new
    @medical_scheme_provider = BillingMedicalSchemeProvider.new
    @provider_type_map = YAML.load_file("#{Rails.root}/config/application.yml")["#{Rails.env
        }"]["scheme.provider.types"].split(",") rescue []

		if params[:user_id].nil?
			redirect_to '/encounters/no_user' and return
		end
		@user = User.find(params[:user_id]) rescue nil?

    	respond_to do |format|
      		format.html # new.html.erb
      		format.xml  { render :xml => @medical_scheme_provider }
    	end
  end

  def edit
  end

  def create
      @medical_scheme_provider = BillingMedicalSchemeProvider.new
      @medical_scheme_provider.provider_type = params[:provider_type]
      @medical_scheme_provider.company_name = params[:company_name]
      @medical_scheme_provider.email_address = params[:email_address]
      @medical_scheme_provider.company_address = params[:company_address]
      @medical_scheme_provider.phone_number_1 = params[:phone_number_1]
      @medical_scheme_provider.phone_number_2 = params[:phone_number_2]
      @medical_scheme_provider.creator  = params[:user_id]
                                    
      
      respond_to do |format|
      		if @medical_scheme_provider.save
        		format.html { redirect_to "/show_medical_scheme_providers?user_id=#{params[:user_id]}" if !params[:user_id].blank? }
        		format.xml  { render :xml => @medical_scheme_provider, :status => :created, :location => @medical_scheme_provider }
      		else
        		format.html { render :action => "new" }
        		format.xml  { render :xml => @medical_scheme_provider.errors, :status => :unprocessable_entity }
      		end
      	end
  end

  def update
  end

  def delete
  end

end
