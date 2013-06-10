ActionController::Routing::Routes.draw do |map|

  map.root :controller => 'clinic', :action => 'index'
  map.create '/create', :controller => 'encounters', :action => 'create'

  map.user_login '/user_login/:id', :controller => 'clinic', :action => 'user_login'

  map.user_logout '/user_logout/:id', :controller => 'clinic', :action => 'user_logout'

  map.set_datetime '/set_datetime', :controller => 'clinic', :action => 'set_datetime'

  map.update_datetime '/update_datetime', :controller => 'clinic', :action => 'update_datetime'

  map.reset_datetime '/reset_datetime', :controller => 'clinic', :action => 'reset_datetime'

  map.overview '/overview', :controller => 'clinic', :action => 'overview'

  map.reports '/reports', :controller => 'clinic', :action => 'reports'

  map.my_account '/my_account', :controller => 'clinic', :action => 'my_account'

  map.administration '/administration', :controller => 'clinic', :action => 'administration'

  map.properties '/settings', :controller => 'clinic' , :action => 'settings'

  map.project_users '/project_users', :controller => 'clinic', :action => 'project_users'

  map.project_users_list '/project_users_list', :controller => 'clinic', :action => 'project_users_list'

  map.add_to_project '/add_to_project', :controller => 'clinic', :action => 'add_to_project'

  map.remove_from_project '/remove_from_project', :controller => 'clinic', :action => 'remove_from_project'

  map.manage_activities '/manage_activities', :controller => 'clinic', :action => 'manage_activities'

  map.check_role_activities '/check_role_activities', :controller => 'clinic', :action => 'check_role_activities'

  map.create_role_activities '/create_role_activities', :controller => 'clinic', :action => 'create_role_activities'

  map.remove_role_activities '/remove_role_activities', :controller => 'clinic', :action => 'remove_role_activities'

  map.project_members '/project_members', :controller => 'clinic', :action => 'project_members'

  map.my_activities '/my_activities', :controller => 'clinic', :action => 'my_activities'

  map.check_user_activities '/check_user_activities', :controller => 'clinic', :action => 'check_user_activities'

  map.create_user_activity '/create_user_activity', :controller => 'clinic', :action => 'create_user_activity'

  map.remove_user_activity '/remove_user_activity', :controller => 'clinic', :action => 'remove_user_activity'

  map.list_observations '/list_observations', :controller => 'encounters', :action => 'list_observations'

  map.void '/void', :controller => 'encounters', :action => 'void'

  map.list_encounters '/list_encounters', :controller => 'encounters', :action => 'list_encounters'

  map.demographics_fields '/demographics_fields', :controller => 'clinic', :action => 'demographics_fields'

  map.show_selected_fields '/show_selected_fields', :controller => 'clinic', :action => 'show_selected_fields'

  map.remove_field '/remove_field', :controller => 'clinic', :action => 'remove_field'

  map.add_field '/add_field', :controller => 'clinic', :action => 'add_field'

  map.show_medical_scheme_providers '/show_medical_scheme_providers', :controller => 'billing_medical_scheme_providers', :action => 'index'

  map.new_medical_scheme_provider '/new_medical_scheme_provider', :controller => 'billing_medical_scheme_providers', :action => 'new'

  map.create_medical_scheme_provider '/create_medical_scheme_provider', :controller => 'billing_medical_scheme_providers', :action => 'create'

  map.show_departments '/show_departments', :controller => 'billing_departments', :action => 'index'

  map.new_department '/new_department', :controller => 'billing_departments', :action => 'new'

  map.create_department '/create_department', :controller => 'billing_departments', :action => 'create'

  map.show_categories '/show_categories', :controller => 'billing_categories', :action => 'index'

  map.new_category '/new_category', :controller => 'billing_categories', :action => 'new'

  map.create_category '/create_category', :controller => 'billing_categories', :action => 'create'

  map.show_categories '/show_services', :controller => 'billing_services', :action => 'index'

  map.new_category '/new_service', :controller => 'billing_services', :action => 'new'

  map.create_category '/create_service', :controller => 'billing_services', :action => 'create'

  map.show_products '/show_products', :controller => 'billing_product', :action => 'index'

  map.new_product '/new_product', :controller => 'billing_product', :action => 'new'

  map.create_product '/create_product', :controller => 'billing_product', :action => 'create'

  map.show_product_types '/show_product_types', :controller => 'billing_product_types', :action => 'index'

  map.new_product_type '/new_product_type', :controller => 'billing_product_types', :action => 'new'

  map.create_product_type '/create_product_type', :controller => 'billing_product_types', :action => 'create'

  map.show_medical_schemes '/show_medical_schemes', :controller => 'billing_medical_schemes', :action => 'index'
  
  map.new_medical_scheme '/new_medical_scheme', :controller => 'billing_medical_schemes', :action => 'new'
  
  map.create_medical_scheme '/create_medical_scheme', :controller => 'billing_medical_schemes', :action => 'create'

  map.show_rules '/show_rules', :controller => 'billing_rules', :action => 'index'

  map.new_rule '/new_rule', :controller => 'billing_rules', :action => 'new'
  
  map.create_rule '/create_rule', :controller => 'billing_rules', :action => 'create'

  map.show_prices '/show_prices', :controller => 'billing_price', :action => 'index'

  map.new_price '/new_price', :controller => 'billing_price', :action => 'new'

  map.create_price '/create_price', :controller => 'billing_price', :action => 'create'

  map.show_account '/show_account', :controller => 'billing_accounts', :action => 'show'

  map.new_account '/new_account', :controller => 'billing_accounts', :action => 'new'
  
  map.create_account '/create_account', :controller => 'billing_accounts', :action => 'create'

  map.show_account_medical_schemes '/show_account_medical_scheme', :controller => 'billing_accounts', :action => 'show_account_medical_scheme'
  
  map.new_account_medical_scheme '/new_account_medical_scheme', :controller => 'billing_account_medical_schemes', :action => 'new'
  
  map.create_account_medical_scheme '/create_account_medical_scheme', :controller => 'billing_account_medical_schemes', :action => 'create'
  
  map.show_patient '/patient/show', :controller => 'patient', :action => :show

  map.show_account_company_agreement '/show_account_company_agreement', :controller => 'billing_accounts', :action => 'show_account_company_agreement'
  
  
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
