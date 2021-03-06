
class ApplicationController < ActionController::Base
  helper :all

  before_filter :start_session

  before_filter :check_user, :except => [:user_login, :user_logout, :missing_program,
    :missing_concept, :no_user, :no_patient, :project_users_list, :check_role_activities]
    
    
  def rescue_action_in_public(exception)
	@message = exception.message
	@backtrace = exception.backtrace.join("\n") unless exception.nil?
	logger.info @message
	logger.info @backtrace
	render :file => "#{RAILS_ROOT}/app/views/errors/error.rhtml", :layout=> false, :status => 404
  end if RAILS_ENV == 'development' || RAILS_ENV == 'test'

  def rescue_action(exception)
    @message = exception.message
    @backtrace = exception.backtrace.join("\n") unless exception.nil?
    logger.info @message
    logger.info @backtrace
    render :file => "#{RAILS_ROOT}/app/views/errors/error.rhtml", :layout=> false, :status => 404
  end if RAILS_ENV == 'production'

  def get_global_property_value(global_property)
		property_value = Settings[global_property]
		if property_value.nil?
			property_value = GlobalProperty.find(:first, :conditions => {:property => "#{global_property}"}
      ).property_value rescue nil
		end
		return property_value
	end

  def create_from_dde_server
    get_global_property_value('create.from.dde.server').to_s == "true" rescue false
  end

  def print_and_redirect(print_url, redirect_url, message = "Printing, please wait...", show_next_button = false, patient_id = nil)
    @print_url = print_url
    @redirect_url = redirect_url
    @message = message
    @show_next_button = show_next_button
    @patient_id = patient_id
    render :template => 'print/print', :layout => nil
  end

  protected

  def start_session
    session[:started] = true
  end

  def check_user

    if !params[:token].nil?
      session[:token] = params[:token]
    end

    if !params[:user_id].nil?
      session[:user_id] = params[:user_id]
    end

    if !params[:location_id].nil?
      session[:location_id] = params[:location_id]
    end

    link = get_global_property_value("user.management.url").to_s rescue nil

    if link.nil?
      flash[:error] = "Missing configuration for <br/>user management connection!"

      redirect_to "/no_user" and return
    end

    # Track final destination
    file = "#{File.expand_path("#{Rails.root}/tmp", __FILE__)}/current.path.yml"

    f = File.open(file, "w")

    f.write("#{Rails.env}:\n    current.path: #{request.referrer}")

    f.close

    if session[:token].nil?
      redirect_to "/user_login?internal=true" and return
    end

  end

end
