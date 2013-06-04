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
    @drug_map = Drug.all(:conditions => ["retired = ? ", 0],:order => "name ASC").map do |drug|
      [drug.name, drug.drug_id]
    end
    @service_map = BillingService.all.map do |service|
      [service.name, service.service_id]
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
    if params["product_type"].upcase.match("DRUG")
      @product.drug_id = params[:drug_id]
    else
      @product.service_id = params[:service_id]
    end
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
  end

  def update
  end

end
