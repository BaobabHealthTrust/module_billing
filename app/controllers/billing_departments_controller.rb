class BillingDepartmentsController < ApplicationController

	def index
    @destination = "/clinic?user_id=#{params[:user_id]}&location_id=#{params[:location_id]}"
		@departments = BillingDepartment.all
    if params[:user_id].nil?
			redirect_to '/encounters/no_user' and return
		end
		@user = User.find(params[:user_id]) rescue nil?

    respond_to do |format|
      		format.html # new.html.erb
      		format.xml  { render :xml => @departments }
    end
    
  end

  def new
		@department = BillingDepartment.new
		if params[:user_id].nil?
			redirect_to '/encounters/no_user' and return
		end
		@user = User.find(params[:user_id]) rescue nil?
		
    	respond_to do |format|
      		format.html # new.html.erb
      		format.xml  { render :xml => @department }
    	end
	end	
		
	def create
      @department = BillingDepartment.new
      @department.name = params[:name]
      @department.creator  = params[:user_id]
      
      respond_to do |format|
      		if @department.save
        		format.html { redirect_to "/show_departments?user_id=#{params[:user_id]}&location_id=#{params[:location_id]}" if !params[:user_id].blank? }
        		format.xml  { render :xml => @department, :status => :created, :location => @department }
      		else
        		format.html { render :action => "new" }
        		format.xml  { render :xml => @department.errors, :status => :unprocessable_entity }
      		end
      	end
	end

  def get_departments
    @departments = BillingDepartment.all(:conditions => ["voided = ?",false]).collect{|department| department.name}
    render :text => "<li>" + @departments.join("</li><li>") + "</li>"
  end

  def edit
   @department = BillingDepartment.find(params[:target_id]) rescue nil
		if params[:user_id].nil?
			redirect_to '/encounters/no_user' and return
		end
		@user = User.find(params[:user_id]) rescue nil?

    	respond_to do |format|
      		format.html # new.html.erb
      		format.xml  { render :xml => @department }
    	end
  end

  def select_department
    @departments = BillingDepartment.all.map do |department|
      [department.name, department.department_id]
    end
  end

  def update
      @department = BillingDepartment.find(params[:department_id])
      @department.name = params[:name]
      respond_to do |format|
        if @department.save
          format.html { redirect_to "/show_departments?user_id=#{params[:user_id]}&location_id=#{params[:location_id]}" if !params[:user_id].blank? }
          format.xml  { render :xml => @department, :status => :created, :location => @department }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @department.errors, :status => :unprocessable_entity }
        end
      end
  end

  def delete
      department = BillingDepartment.find(params[:target_id])
      categories = BillingCategory.find_all_by_department_id_and_voided(department.department_id,false)
      project = get_global_property_value("project.name") rescue "Unknown"
      user_id = params[:user_id]
      void_time = Time.now
      void_message = "Voided through #{project}"

      categories.each do |category|
        category.billing_products.each do |product|
          product.billing_prices.each do |price|
            price.void(void_message,void_time,user_id)
          end
          product.void(void_message,void_time,user_id)
        end
        category.void(void_message,void_time,user_id)
      end
      department.void(void_message,void_time,user_id)
      
      respond_to do |format|
        	format.html { redirect_to "/show_departments?user_id=#{params[:user_id]}&location_id=#{params[:location_id]}" if !params[:user_id].blank? }
      end
  end
end
