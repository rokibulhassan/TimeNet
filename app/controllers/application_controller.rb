class ApplicationController < ActionController::Base
  include SimpleCaptcha::ControllerHelpers
  protect_from_forgery with: :exception
  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end
  before_filter :update_sanitized_params, if: :devise_controller?

  helper_method :current_client, :uploaded_notice

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:password_change_required) }
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "You do not have permission to perform that task.  Please contact your administrator for further details."
    redirect_to current_user.admin? ? clients_path : dashboard_welcomes_path
  end

  def after_sign_in_path_for(resource)
    resource.admin? ? clients_path : dashboard_welcomes_path
  end

  def current_client
    signed_in? ? current_user.client : nil
  end

  def uploaded_notice(klass, success, failed)
    "<b class='badge alert-info'>#{success}</b> #{klass} successfully uploaded and  <b class='badge alert-danger'>#{failed}</b> #{klass} Failed to Upload.".html_safe
  end

  protected

  def check_if_admin
    if signed_in?
      unless current_user.admin?
        redirect_to root_url
        flash[:error] = "You don't have enough permission to  Access this resource!"
      end
    else
      flash[:error] = "Please sign in!"
      redirect_to user_session_path
    end
  end

end
