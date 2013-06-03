class BillingDepartmentsController < ApplicationController

	def new
		@billing_department = BillingDepartment.new

		if params[:user_id].nil?
			redirect_to '/encounters/no_user' and return
		end
		@user = User.find(params[:user_id]) rescue nil?
		
    	respond_to do |format|
      		format.html # new.html.erb
      		format.xml  { render :xml => @billing_department }
    	end
	end	
		
	def create
	
		@billing_department = BillingDepartment.new(params[:billing_department])
		respond_to do |format|
      		if @billing_department.save
        		flash[:notice] = 'Admission was successfully created.'
        		format.html { redirect_to(@billing_department) }
        		format.xml  { render :xml => @billing_department, :status => :created, :location => @billing_department }
      		else
        		format.html { render :action => "new" }
        		format.xml  { render :xml => @billing_department.errors, :status => :unprocessable_entity }
      		end
      	end
	end
end
