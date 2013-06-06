class BillingDepartmentsController < ApplicationController

	def index
    @destination = "/clinic?user_id=#{params[:user_id]}"
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
        		format.html { redirect_to "/show_departments?user_id=#{params[:user_id]}" if !params[:user_id].blank? }
        		format.xml  { render :xml => @department, :status => :created, :location => @department }
      		else
        		format.html { render :action => "new" }
        		format.xml  { render :xml => @department.errors, :status => :unprocessable_entity }
      		end
      	end
	end

  def get_departments
    @departments = BillingDepartment.all(:conditions => ["retired = ?",false]).collect{|department| department.name}
    render :text => "<li>" + @departments.join("</li><li>") + "</li>"
  end
end
