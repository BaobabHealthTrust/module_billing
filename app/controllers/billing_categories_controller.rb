class BillingCategoriesController < ApplicationController

	def index
    @destination = "/clinic?user_id=#{params[:user_id]}"
		@categories = BillingCategory.all
    if params[:user_id].nil?
			redirect_to '/encounters/no_user' and return
		end
		@user = User.find(params[:user_id]) rescue nil?

    respond_to do |format|
      		format.html # new.html.erb
      		format.xml  { render :xml => @categories }
    end
    
  end

  def new
		@category = BillingCategory.new
    @departments_map = BillingDepartment.all.map do |department|
      [department.name, department.department_id]
    end
		if params[:user_id].nil?
			redirect_to '/encounters/no_user' and return
		end
		@user = User.find(params[:user_id]) rescue nil?
		
    	respond_to do |format|
      		format.html # new.html.erb
      		format.xml  { render :xml => @category }
    	end
	end	
		
	def create
		@category = BillingCategory.new
    @category.name = params[:name]
    @category.department_id = params[:department_id]
    @category.creator = params[:user_id]
    
	 respond_to do |format|
      		if @category.save
        		format.html { redirect_to "/show_categories?user_id=#{params[:user_id]}" if !params[:user_id].blank? }
        		format.xml  { render :xml => @category, :status => :created, :location => @category }
      		else
        		format.html { render :action => "new" }
        		format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      		end
      	end
	end
end
