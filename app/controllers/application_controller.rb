class ApplicationController < ActionController::Base
  include SimpleCaptcha::ControllerHelpers
  protect_from_forgery with: :exception
  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "You don't have enough permission to  Access this resource!"
    redirect_to root_url
  end

  def after_sign_in_path_for(resource)
    resource.admin? ? clients_path : dashboard_welcomes_path
  end

end
