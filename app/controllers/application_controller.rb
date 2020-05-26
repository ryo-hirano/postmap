class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  layout :layout_by_resource

  def set_parents
    @parents = Category.where(ancestry: nil)
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :image])
  end

  def layout_by_resource
    if devise_controller?
      "sub"
    else
      "application"
    end
  end
end
