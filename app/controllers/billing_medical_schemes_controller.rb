class BillingMedicalSchemesController < ApplicationController

  def index
    	@destination = "/clinic?user_id=#{params[:user_id]}"
		@medical_schemes = BillingMedicalScheme.all
    	if params[:user_id].nil?
			redirect_to '/encounters/no_user' and return
		end
		@user = User.find(params[:user_id]) rescue nil?

    	respond_to do |format|
      		format.html # new.html.erb
      		format.xml  { render :xml => @rules }
    	end
  end

  def new
		@medical_scheme = BillingMedicalScheme.new
    	@providers_map = BillingMedicalSchemeProvider.all.map do |provider|
      		[provider.company_name, provider.medical_scheme_provider_id]
    	end


		if params[:user_id].nil?
			redirect_to '/encounters/no_user' and return
		end
		@user = User.find(params[:user_id]) rescue nil?
    	respond_to do |format|
      		format.html # new.html.erb
      		format.xml  { render :xml => @medical_scheme }
    	end
  
  end

  def create
		@medical_scheme = BillingMedicalScheme.new(params[:medical_scheme])  
		
		@medical_scheme.name = params[:name]
		@medical_scheme.medical_scheme_provider_id = params[:medical_scheme_provider_id]
		@medical_scheme.creator = params[:user_id]
		
  		respond_to do |format|
      		if @medical_scheme.save
        		flash[:notice] = 'Rule was successfully created.'
        		format.html { redirect_to "/show_medical_schemes?user_id=#{params[:user_id]}" if !params[:user_id].blank? }
        		format.xml  { render :xml => @medical_scheme, :status => :created, :location => @medical_scheme }
      		else
        		format.html { render :action => "new" }
        		format.xml  { render :xml => @medical_scheme.errors, :status => :unprocessable_entity }
      		end
      	end
  end

  def edit
  end

  def update
  end

end
