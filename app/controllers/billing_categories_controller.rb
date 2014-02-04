class BillingCategoriesController < ApplicationController

	def index
    @destination = "/clinic?user_id=#{params[:user_id]}&location_id=#{params[:location_id]}"
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
        		format.html { redirect_to "/show_categories?user_id=#{params[:user_id]}&location_id=#{params[:location_id]}" if !params[:user_id].blank? }
        		format.xml  { render :xml => @category, :status => :created, :location => @category }
      		else
        		format.html { render :action => "new" }
        		format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      		end
      	end
	end

  def get_categories
    params[:department]
    search_string = (params[:department] || '')
    department_id = BillingDepartment.find_by_name(search_string).department_id
    @billing_categories = BillingCategory.all(:conditions => ["department_id = ? ", department_id]).collect{|category| category.name}
    render :text => "<li>" + @billing_categories.join("</li><li>") + "</li>"
  end

  def select_category
    department_id = params[:department_id]
    department_name = BillingDepartment.find(department_id).name
    @categories = BillingCategory.all(:conditions => ["department_id = ? ", department_id]).map do |category|
      [category.name, category.category_id]
    end
  end

  def edit
   @category = BillingCategory.find(params[:target_id]) rescue nil
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

  def update
      @category= BillingCategory.find(params[:category_id])
      @category.name = params[:name]
      @category.department_id = params[:department_id]
      respond_to do |format|
        if @category.save
          format.html { redirect_to "/show_categories?user_id=#{params[:user_id]}&location_id=#{params[:location_id]}" if !params[:user_id].blank? }
          format.xml  { render :xml => @category, :status => :created, :location => @category }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
        end
      end
  end

  def delete
      category = BillingCategory.find(params[:target_id])
      products = BillingProduct.find_all_by_category_id_and_voided(category.category_id, false)
      project = get_global_property_value("project.name") rescue "Unknown"
      user_id = params[:user_id]
      void_time = Time.now
      void_message = "Voided through #{project}"

      products.each do |product|
          product.billing_prices.each do |price|
            price.void(void_message,void_time,user_id)
          end
          product.void(void_message,void_time,user_id)
        end
      category.void(void_message,void_time,user_id)
      
      respond_to do |format|
        	format.html { redirect_to "/show_categories?user_id=#{params[:user_id]}&location_id=#{params[:location_id]}" if !params[:user_id].blank? }
      end
  end

end
