class BillingReportsController < ApplicationController
  def select
	@user_id = params[:user_id]
	@location_id = params[:location_id]
  end

  def overview_result
    @destination = "/clinic?user_id=#{params[:user_id]}&location_id=#{params[:location_id]}"
    @selSelect = params[:report_by] rescue nil
    @selYear = params[:year] rescue nil
    @selMonth = params[:month] rescue nil
    @selQtr = "#{par      	  raise patient.to_yamlams[:selQtr].gsub(/&/, "_")}" rescue nil
	  @location =  Location.current_health_center.name rescue ''

	case params[:report_by]
	  when "Day"
	  @start_date = params[:start_date].to_date.strftime("%Y-%m-%d 00:00:00")
	  @end_date = params[:end_date].to_date.strftime("%Y-%m-%d 23:59:59")
    
	  when "Month"
		@start_date = ("#{params[:year]}-#{params[:month]}-01").to_date.strftime("%Y-%m-%d 23:59:59")
		@end_date = ("#{params[:year]}-#{params[:month]}-#{ (params[:month].to_i != 12 ?
		  ("2010-#{params[:month].to_i + 1}-01".to_date - 1).strftime("%d") : 31) }").to_date.strftime("%Y-%m-%d 00:00:00")

	  when "quarter"
		start_date = params[:selQtr].to_s.gsub(/&max=(.+)$/,'')
		end_date = params[:selQtr].to_s.gsub(/^min=(.+)&max=/,'')

			@start_date = start_date.gsub(/^min=/,'')
			@end_date		= end_date
	end
  
    @payment_methods_map = YAML.load_file("#{Rails.root}/config/application.yml")["#{Rails.env
        }"]["payment.methods"].split(",") rescue []
  
	@results = []
	
	invoicelines = BillingInvoiceLine.find(:all, :conditions => ["created_at BETWEEN ? AND ?",@start_date,@end_date])
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
	
	@totals = {}
	@total_sum = 0
	@payment_methods_map.each do |method|
	  @totals[method] = 0
	end
 
	@results.each do |result|
	  @payment_methods_map.each do |method|
		@totals[method] += result[method] rescue 0
	  end
	end
	
	@payment_methods_map.each do |method|
	  @total_sum += @totals[method] rescue 0
	end


	if @selSelect.include?('Month')
		@report_type =	"<b>Billing Monthly Report</b><br/> " + @start_date.to_date.strftime("%B") + "  " + @selYear
	elsif @selSelect.include?('Day')
		@report_type = "<b>Billing Report From</b><br/>" + @start_date.to_date.strftime("%d-%B-%Y") + " To " + @end_date.to_date.strftime("%d-%B-%Y")
	else
		@report_type = "<b>Billing Quarterly Report</b><br/>" + @start_date.to_date.strftime("%d/%B/%Y") + "  to  " + @end_date.to_date.strftime("%d/%B/%Y")
	end

  @destination = "/clinic?user_id=#{params[:user_id]}&location_id=#{params[:location_id]}"

  end


end
