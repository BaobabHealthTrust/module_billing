class BillingServicesController < ApplicationController

	def index
    	@destination = "/clinic?user_id=#{params[:user_id]}"
		@services = BillingService.all
    	if params[:user_id].nil?
			redirect_to '/encounters/no_user' and return
		end
		@user = User.find(params[:user_id]) rescue nil?

    	respond_to do |format|
      		format.html # new.html.erb
      		format.xml  { render :xml => @services }
    	end
  end

  def new
		@service = BillingService.new
    	@categories_map = BillingCategory.all.map do |category|
      		[category.name, category.category_id]
    	end
   		 @service_type = ""
		if params[:user_id].nil?
			redirect_to '/encounters/no_user' and return
		end
		@user = User.find(params[:user_id]) rescue nil?
    	respond_to do |format|
      		format.html # new.html.erb
      		format.xml  { render :xml => @service }
    	end
  end	
			
		
		
  def create
		@service = BillingService.new
    	@service.name = params[:name]
    	@service.service_type = params[:service_type]
    	@service.category_id = params[:category_id]
    	@service.creator = params[:user_id]

		respond_to do |format|
			if @service.save
				format.html { redirect_to "/show_services?user_id=#{params[:user_id]}" if !params[:user_id].blank? }
				format.xml  { render :xml => @service, :status => :created, :location => @service }
			else
				format.html { render :action => "new" }
				format.xml  { render :xml => @service.errors, :status => :unprocessable_entity }
			end
		end
	end
end
