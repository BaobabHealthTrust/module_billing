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
# 		raise @billing_service.to_yaml
		respond_to do |format|
      		if @billing_service.save
        		flash[:notice] = 'Admission was successfully created.'
        		format.html { redirect_to(@billing_service) }
        		format.xml  { render :xml => @billing_service, :status => :created, :location => @billing_service }
      		else
        		format.html { render :action => "new" }
        		format.xml  { render :xml => @billing_service.errors, :status => :unprocessable_entity }
      		end
      	end
	end
end
