class BillingPriceController < ApplicationController

  def index
    @destination = "/clinic?user_id=#{params[:user_id]}"
		@prices = BillingPrice.all
    if params[:user_id].nil?
			redirect_to '/encounters/no_user' and return
		end
		@user = User.find(params[:user_id]) rescue nil?

    respond_to do |format|
      		format.html # new.html.erb
      		format.xml  { render :xml => @prices }
    end
  end

  def new
		@price = BillingPrice.new
    @product_map = BillingProduct.all.map do |product|
      [product.billing_service.name || product.drug.name, product.product_id] rescue []
    end
    @price_type_map = YAML.load_file("#{Rails.root}/config/application.yml")["#{Rails.env
        }"]["price.types"].split(",") rescue []
    
		if params[:user_id].nil?
			redirect_to '/encounters/no_user' and return
		end
		@user = User.find(params[:user_id]) rescue nil?

    	respond_to do |format|
      		format.html # new.html.erb
      		format.xml  { render :xml => @price }
    	end
	end

	def create
		@price = BillingPrice.new
    @price.product_id = params[:product_id]
    @price.price_type = params[:price_type]
    @price.price = params[:price]
    @price.creator = params[:user_id]

     respond_to do |format|
            if @price.save
              format.html { redirect_to "/show_prices?user_id=#{params[:user_id]}" if !params[:user_id].blank? }
              format.xml  { render :xml => @price, :status => :created, :location => @price }
            else
              format.html { render :action => "new" }
              format.xml  { render :xml => @price.errors, :status => :unprocessable_entity }
            end
     end
  end

  def edit
  end

  def update
  end

end
