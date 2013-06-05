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
    @products = BillingProduct.all

    product_hash_map = {}
    @products.each do |product|
      unless product.drug_id.blank?
        product_hash_map[product.product_id] = product.drug.name
      else
        product_hash_map[product.product_id] = product.billing_service.name
      end
    end
    
    @product_map = product_hash_map.each.map {|product| [product[1],product[0]]}

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
