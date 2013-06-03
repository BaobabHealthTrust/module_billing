class BillingServicesController < ApplicationController

	def new
		@billing_service = BillingService.new
		if params[:user_id].nil?
			redirect_to '/encounters/no_user' and return
		end
		@user = User.find(params[:user_id]) rescue nil?

    	respond_to do |format|
      		format.html # new.html.erb
      		format.xml  { render :xml => @billing_service }
    	end
	end	
		
	def create
		@billing_service = BillingService.new(params[:billing_service])
		
		if BillingCategory.find_by_category_id(@billing_service.category_id).name.capitalize != "accommodation".capitalize
			@billing_service.service_type = "service"
		else
			@billing_service.service_type = "accomodation"
		end
		
		
# 		
# 		@billing_product = BillingProduct.new
# 		@billing_product.service_id = @billing_service.service_id
# 		@billing_product.creator = @billing_service.creator
# 		@billing_product.save
		
		
		respond_to do |format|
      		if @billing_service.save
        		flash[:notice] = 'Admission was successfully created.'
        		format.html { redirect_to(:controller => "billing_product", :action => :create, :service_id => @billing_service.service_id, :creator => @billing_service.creator) }
        		format.xml  { render :xml => @billing_service, :status => :created, :location => @billing_service }
      		else
        		format.html { render :action => "new" }
        		format.xml  { render :xml => @billing_service.errors, :status => :unprocessable_entity }
      		end
      	end
	end
end
