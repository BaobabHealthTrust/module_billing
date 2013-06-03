class BillingProductController < ApplicationController
   	def new
		@billing_product = BillingProduct.new
		if params[:user_id].nil?
			redirect_to '/encounters/no_user' and return
		end
		@user = User.find(params[:user_id]) rescue nil?

    	respond_to do |format|
      		format.html # new.html.erb
      		format.xml  { render :xml => @billing_product }
    	end
  
  	end

 	 def create
		@billing_product = BillingProduct.new(params[:billing_product])  
		
		@billing_product.service_id = params[:service_id]
		@billing_product.creator = params[:creator]
		
  		respond_to do |format|
      		if @billing_product.save
        		flash[:notice] = 'Admission was successfully created.'
        		format.html { redirect_to(@billing_product)}
        		format.xml  { render :xml => @billing_product, :status => :created, :location => @billing_product }
      		else
        		format.html { render :action => "new" }
        		format.xml  { render :xml => @billing_product.errors, :status => :unprocessable_entity }
      		end
      	end
  end
end
