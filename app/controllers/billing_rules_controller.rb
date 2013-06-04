class BillingRulesController < ApplicationController

  def index
    	@destination = "/clinic?user_id=#{params[:user_id]}"
		@rules = BillingRules.all
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
		@rule = BillingRules.new
    	@medical_schemes_map = BillingMedicalScheme.all.map do |medical_scheme|
      		[medical_scheme.name, medical_scheme.medical_scheme_id]
    	end

    	@products_map = BillingProduct.all.map do |product|
			unless product.service_id.blank?
				[product.billing_service.name , product.product_id]
			else
				[product.drug.name , product.product_id]
    		end
    	end


		if params[:user_id].nil?
			redirect_to '/encounters/no_user' and return
		end
		@user = User.find(params[:user_id]) rescue nil?
    	respond_to do |format|
      		format.html # new.html.erb
      		format.xml  { render :xml => @rule }
    	end
  
  end

  def create
		@rule = BillingRules.new(params[:rule])  
		@rule.product_id = params[:product_id]
		@rule.rate = params[:rate]
		@rule.medical_scheme_id = params[:medical_scheme_id]
		@rule.name = params[:name]
  		respond_to do |format|
      		if @rule.save
        		format.html { redirect_to "/show_rules?user_id=#{params[:user_id]}" if !params[:user_id].blank? }
        		format.xml  { render :xml => @rule, :status => :created, :location => @rule }
      		else
        		format.html { render :action => "new" }
        		format.xml  { render :xml => @rule.errors, :status => :unprocessable_entity }
      		end
      	end
  end

  def edit
  end

  def update
  end

end
