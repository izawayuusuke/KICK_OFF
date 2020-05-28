class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  private
    def after_sign_in_path_for(resource)
      posts_path
    end

    def after_sign_out_path_for(resource)
      new_user_session_path
    end

    def admin_user?
      redirect_back(fallback_location: root_path) unless current_user.admin == true
    end

    def set_post
      @post = Post.find(params[:post_id])
    end

    def all_leagues
      @leagues = League.all
      @teams = Team.all.paginate(params, 20)
    end

    def set_position
      @players = @team.players.order(uniform_number: :asc)
      @GK = @players.where(position: "GK")
      @DF = @players.where(position: "DF")
      @MF = @players.where(position: "MF")
      @FW = @players.where(position: "FW")
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end
end
