class BillingReportsController < ApplicationController
  def select
  	@start_date
  	@finish_date
  	@departments
  	
  end

  def simple_result
# 	@start_date = params[:start_date]
# 	@finish_date = params[:finish_date]
# 	@departments = params[:departments]
    @destination = "/clinic?user_id=#{params[:user_id]}"
	@results = []
	invoicelines = BillingInvoiceLine.all
	invoicelines.each do |line|
	  @results[line.billing_product.billing_category.billing_department.department_id] = {} if @results[line.billing_product.billing_category.billing_department.department_id].nil?
	  @results[line.billing_product.billing_category.billing_department.department_id]["department_name"] = line.billing_product.billing_category.billing_department.name
	  if @results[line.billing_product.billing_category.billing_department.department_id][line.billing_invoice.payment_method].nil?
	    @results[line.billing_product.billing_category.billing_department.department_id][line.billing_invoice.payment_method] = line.final_amount 
	  else
	    @results[line.billing_product.billing_category.billing_department.department_id][line.billing_invoice.payment_method] = line.final_amount + @results[line.billing_product.billing_category.billing_department.department_id][line.billing_invoice.payment_method]
	  end
	  
	  #calculate total of each department
	  if @results[line.billing_product.billing_category.billing_department.department_id]["total"].nil?
	    @results[line.billing_product.billing_category.billing_department.department_id]["total"] = line.final_amount
  	  else
  	    @results[line.billing_product.billing_category.billing_department.department_id]["total"] = @results[line.billing_product.billing_category.billing_department.department_id]["total"] + line.final_amount
	  end
	end 
	
	
	#calculate total of each payment method
	@total_cash = 0
	@total_scheme = 0
	@total_company = 0
	
	@results.each do |result|
	  next if result.nil?
	  if not result["cash"].nil?
	    @total_cash += result["cash"]
	  elsif not result["medical scheme"].nil?
		@total_scheme += result["medical scheme"]
	  elsif not result["company agreement"].nil?
	    @total_company += result["company agreement"]
	  else
	  end
	end
	@total_sum = @total_cash + @total_scheme + @total_company
  end
end
