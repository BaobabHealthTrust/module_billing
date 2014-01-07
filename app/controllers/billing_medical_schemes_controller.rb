  class BillingMedicalSchemesController < ApplicationController

  def index
    	@destination = "/clinic?user_id=#{params[:user_id]}&location_id=#{params[:location_id]}"
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
        		#flash[:notice] = 'Rule was successfully created.'
        		format.html { redirect_to "/show_medical_schemes?user_id=#{params[:user_id]}&location_id=#{params[:location_id]}" if !params[:user_id].blank? }
        		format.xml  { render :xml => @medical_scheme, :status => :created, :location => @medical_scheme }
      		else
        		format.html { render :action => "new" }
        		format.xml  { render :xml => @medical_scheme.errors, :status => :unprocessable_entity }
      		end
      	end
  end

  def edit
    @medical_scheme = BillingMedicalScheme.find(params[:target_id]) rescue nil
    @providers_map = BillingMedicalSchemeProvider.all.map do |provider|
          [provider.company_name, provider.medical_scheme_provider_id]
    end

    if params[:user_id].nil?
      redirect_to '/encounters/no_user' and return
    end
    @user = User.find(params[:user_id]) rescue nil?

    respond_to do |format|
        format.html # edit.html.erb
        format.xml  { render :xml => @medical_scheme }
    end
  end

  def update
    @medical_scheme = BillingMedicalScheme.find(params[:target_id]) rescue nil
    @provider = BillingMedicalSchemeProvider.find(params[:medical_scheme_provider_id]) rescue nil

    @medical_scheme.name = params[:name]
    @medical_scheme.medical_scheme_provider_id = params[:medical_scheme_provider_id]

    respond_to do |format|
       if @medical_scheme.save
        #flash[:notice] = 'Successfully Edited.'
        format.html { redirect_to "/show_medical_schemes?user_id=#{params[:user_id]}&location_id=#{params[:location_id]}" if !params[:user_id].blank? }
        format.xml  { render :xml => @medical_scheme, :status => :created, :location => @medical_scheme }
       else
        format.html { render :action => "new" }
        format.xml  { render :xml => @medical_scheme.errors, :status => :unprocessable_entity }
       end
     end
  end

  def delete
    @medical_scheme = BillingMedicalScheme.find(params[:target_id]) rescue nil
    rules = BillingRules.find_all_by_medical_scheme_id_and_voided(@medical_scheme.medical_scheme_id,false)
    project = get_global_property_value("project.name") rescue "Unknown"
    void_time = Time.now
    void_message = "Voided through #{project}"
    user_id = params[:user_id]

    #rules = @medical_scheme.billing_rules
    #accounts = @medical_scheme.billing_accounts

    rules.each do |rule|
      rule.billing_invoice_lines.each do |invoice|
        invoice.void(void_message, void_time, user_id)
      end
    end
=begin
    accounts.each do |account|
      account.
=end
     @medical_scheme.void(void_message, void_time, user_id)
     respond_to do |format|
       format.html { redirect_to "/show_medical_schemes?user_id=#{params[:user_id]}&location_id=#{params[:location_id]}" if !params[:user_id].blank? }
     end
  end

end
