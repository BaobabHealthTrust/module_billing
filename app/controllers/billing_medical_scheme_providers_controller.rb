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
  
  def edit
  	  @medical_scheme_provider = BillingMedicalSchemeProvider.find(params[:target_id])
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

  
  def update
     @medical_scheme_provider = BillingMedicalSchemeProvider.find(params[:medical_scheme_provider_id])
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
        		format.html { render :action => "edit" }
        		format.xml  { render :xml => @medical_scheme_provider.errors, :status => :unprocessable_entity }
      		end
      	end
  end

  def delete
      medical_scheme_provider = BillingMedicalSchemeProvider.find(params[:target_id])
      
      billing_medical_schemes = BillingMedicalScheme.find_all_by_medical_scheme_provider_id_and_voided(medical_scheme_provider.medical_scheme_provider_id, false)
      
      project = get_global_property_value("project.name") rescue "Unknown"
      user_id = params[:user_id]
      void_time = Time.now
      void_message = "Voided through #{project}"
      
       billing_medical_schemes.each do |billing_medical_scheme|
          billing_medical_scheme.void(void_message,void_time,user_id)
        end
      
      medical_scheme_provider.void(void_message,void_time,user_id)
      respond_to do |format|
        	format.html { redirect_to "/show_medical_scheme_providers?user_id=#{params[:user_id]}" if !params[:user_id].blank? }
      end
  end

end
