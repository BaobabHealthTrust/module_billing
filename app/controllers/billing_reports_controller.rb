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
	  
	  #calculate total
	  if @results[line.billing_product.billing_category.billing_department.department_id]["total"].nil?
	    @results[line.billing_product.billing_category.billing_department.department_id]["total"] = line.final_amount
  	  else
  	    @results[line.billing_product.billing_category.billing_department.department_id]["total"] = @results[line.billing_product.billing_category.billing_department.department_id]["total"] + line.final_amount
	  end
	  
	end 
  end
end
