class BillingCategoriesController < ApplicationController

	def new
		@billing_category = BillingCategory.new
		if params[:user_id].nil?
			redirect_to '/encounters/no_user' and return
		end
		@user = User.find(params[:user_id]) rescue nil?
		
    	respond_to do |format|
      		format.html # new.html.erb
      		format.xml  { render :xml => @billing_category }
    	end
	end	
		
	def create
	
		@billing_category = BillingCategory.new(params[:billing_category])
# 		raise @billing_category.to_yaml
		respond_to do |format|
      		if @billing_category.save
        		flash[:notice] = 'Admission was successfully created.'
        		format.html { redirect_to(@billing_category) }
        		format.xml  { render :xml => @billing_category, :status => :created, :location => @billing_category }
      		else
        		format.html { render :action => "new" }
        		format.xml  { render :xml => @billing_category.errors, :status => :unprocessable_entity }
      		end
      	end
	end
end
