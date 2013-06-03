class BillingPricesController < ApplicationController

  	def new
		@billing_price = BillingPrice.new
		if params[:user_id].nil?
			redirect_to '/encounters/no_user' and return
		end
		@user = User.find(params[:user_id]) rescue nil?

    	respond_to do |format|
      		format.html # new.html.erb
      		format.xml  { render :xml => @billing_price }
    	end
  
  	end


	def create
		@billing_price = BillingPrice.new(params[:billing_price])
		
		respond_to do |format|
      		if @billing_price.save
        		flash[:notice] = 'Admission was successfully created.'
        		format.html { redirect_to(@billing_price) }
        		format.xml  { render :xml => @billing_price, :status => :created, :location => @billing_price }
      		else
        		format.html { render :action => "new" }
        		format.xml  { render :xml => @billing_price.errors, :status => :unprocessable_entity }
      		end
      	end
	end
end
