class BillingProductController < ApplicationController

  def index
    @destination = "/clinic?user_id=#{params[:user_id]}"
		@products = BillingProduct.all
    if params[:user_id].nil?
			redirect_to '/encounters/no_user' and return
		end
		@user = User.find(params[:user_id]) rescue nil?

    respond_to do |format|
      		format.html # new.html.erb
      		format.xml  { render :xml => @products }
    end
  end

  def new
		@product = BillingProduct.new
    @product_type_map = BillingProductType.all.map do |product_type|
      [product_type.name, product_type.product_type_id] rescue []
    end

    @category_map = BillingCategory.all.map do |category|
      [category.billing_department.name + " - " + category.name, category.category_id] rescue []
    end
    
		if params[:user_id].nil?
			redirect_to '/encounters/no_user' and return
		end
		@user = User.find(params[:user_id]) rescue nil?

    	respond_to do |format|
      		format.html # new.html.erb
      		format.xml  { render :xml => @product }
    	end
	end

	def create
    
		@product = BillingProduct.new
    @product.name = params[:name]
    @product.category_id = params[:category_id]
    @product.product_type_id = [:product_type]
    @product.creator = params[:user_id]
	  
     respond_to do |format|
            if @product.save
              format.html { redirect_to "/show_products?user_id=#{params[:user_id]}" if !params[:user_id].blank? }
              format.xml  { render :xml => @products, :status => :created, :location => @product }
            else
              format.html { render :action => "new" }
              format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
            end
     end
  end

  def edit
    @product = BillingProduct.find(params[:target_id])
    @product_type_map = BillingProductType.all.map do |product_type|
      [product_type.name, product_type.product_type_id] rescue []
    end

    @category_map = BillingCategory.all.map do |category|
      [category.billing_department.name + " - " + category.name, category.category_id] rescue []
    end

		if params[:user_id].nil?
			redirect_to '/encounters/no_user' and return
		end
		@user = User.find(params[:user_id]) rescue nil?

    	respond_to do |format|
      		format.html # new.html.erb
      		format.xml  { render :xml => @product }
    	end
  end

  def update
      @product = BillingProduct.find(params[:product_id])
      @product.name = params[:name]
      @product.category_id = params[:category_id]
      @product.product_type_id = [:product_type]
      respond_to do |format|
        if @product.save
          format.html { redirect_to "/show_products?user_id=#{params[:user_id]}" if !params[:user_id].blank? }
          format.xml  { render :xml => @product, :status => :created, :location => @product }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
        end
      end
  end

  def delete
      product = BillingProduct.find(params[:target_id])
      prices = BillingPrice.find_all_by_product_id_and_voided(product.product_id, false)
      project = get_global_property_value("project.name") rescue "Unknown"
      user_id = params[:user_id]
      void_time = Time.now
      void_message = "Voided through #{project}"

      prices.each do |price|
        price.void(void_message,void_time,user_id)
      end
      product.void(void_message,void_time,user_id)
      respond_to do |format|
        	format.html { redirect_to "/show_products?user_id=#{params[:user_id]}" if !params[:user_id].blank? }
      end
  end

  def get_products
    params[:department]
    search_string = (params[:category] || '')
    category_id = BillingCategory.find_by_name(search_string).category_id
    @billing_products = BillingProduct.all(:conditions => ["category_id = ? ", category_id]).collect{|product| product.name}
    render :text => "<li>" + @billing_products.join("</li><li>") + "</li>"
  end

end
