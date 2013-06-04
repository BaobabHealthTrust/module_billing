class BillingRulesController < ApplicationController

  def index
    	@destination = "/clinic?user_id=#{params[:user_id]}"
		@rules = BillingRule.all
    	if params[:user_id].nil?
			redirect_to '/encounters/no_user' and return
		end
		@user = User.find(params[:user_id]) rescue nil?

    	respond_to do |format|
      		format.html # new.html.erb
      		format.xml  { render :xml => @rules }
    	end
  end

  def new
		@rule = BillingRule.new
		if params[:user_id].nil?
			redirect_to '/encounters/no_user' and return
		end
		@user = User.find(params[:user_id]) rescue nil?

    	respond_to do |format|
      		format.html # new.html.erb
      		format.xml  { render :xml => @rule }
    	end
  
  end

  def create
		@rule = BillingRule.new(params[:rule])  
		
  		respond_to do |format|
      		if @rule.save
        		flash[:notice] = 'Rule was successfully created.'
        		format.html { redirect_to(@rule)}
        		format.xml  { render :xml => @rule, :status => :created, :location => @rule }
      		else
        		format.html { render :action => "new" }
        		format.xml  { render :xml => @rule.errors, :status => :unprocessable_entity }
      		end
      	end
  end

  def edit
  end

  def update
  end

end
