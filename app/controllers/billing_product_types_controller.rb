class BillingProductTypesController < ApplicationController

  def index
    @destination = "/clinic?user_id=#{params[:user_id]}&location_id=#{params[:location_id]}"
		@product_types = BillingProductType.all
    if params[:user_id].nil?
			redirect_to '/encounters/no_user' and return
		end
		@user = User.find(params[:user_id]) rescue nil?

    respond_to do |format|
      		format.html # new.html.erb
      		format.xml  { render :xml => @product_types }
    end
  end

  def new
		@product_type = BillingProductType.new
    
		if params[:user_id].nil?
			redirect_to '/encounters/no_user' and return
		end
		@user = User.find(params[:user_id]) rescue nil?

    	respond_to do |format|
      		format.html # new.html.erb
      		format.xml  { render :xml => @product_type }
    	end
	end

	def create
		@product_type = BillingProductType.new
    @product_type.name = params[:product_type_name]
    @product_type.creator = params[:user_id]

     respond_to do |format|
            if @product_type.save
              format.html { redirect_to "/show_product_types?user_id=#{params[:user_id]}&location_id=#{params[:location_id]}" if !params[:user_id].blank? }
              format.xml  { render :xml => @product_type, :status => :created, :location => @product_type }
            else
              format.html { render :action => "new" }
              format.xml  { render :xml => @product_type.errors, :status => :unprocessable_entity }
            end
     end
  end

  def edit
    @product_type = BillingProductType.find(params[:target_id])
    
		if params[:user_id].nil?
			redirect_to '/encounters/no_user' and return
		end
		@user = User.find(params[:user_id]) rescue nil?

    	respond_to do |format|
      		format.html # new.html.erb
      		format.xml  { render :xml => @product_type }
    	end
  end

  def update
      @product_type = BillingProductType.find(params[:product_type_id])
      @product_type.name = params[:name]
      
      respond_to do |format|
        if @product_type.save
          format.html { redirect_to "/show_product_types?user_id=#{params[:user_id]}&location_id=#{params[:location_id]}" if !params[:user_id].blank? }
          format.xml  { render :xml => @product_type, :status => :created, :location => @product_type }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @product_type.errors, :status => :unprocessable_entity }
        end
      end
  end

  def delete
      product_type = BillingProductType.find(params[:target_id])
      project = get_global_property_value("project.name") rescue "Unknown"
      user_id = params[:user_id]
      void_time = Time.now
      void_message = "Voided through #{project}"

      product_type.void(void_message,void_time,user_id)
      respond_to do |format|
        	format.html { redirect_to "/show_product_types?user_id=#{params[:user_id]}&location_id=#{params[:location_id]}" if !params[:user_id].blank? }
      end
  end

end
