class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  private
    def after_sign_in_path_for(resource)
      posts_path(resource)
    end

    def after_sign_out_path_for(resource)
      new_user_session_path
    end

    def set_post
      @post = Post.find(params[:id])
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone_number])
    end
end
