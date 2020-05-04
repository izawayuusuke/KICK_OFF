class HomesController < ApplicationController
  def top
    if user_signed_in?
      redirect_to home_path
    end
  end

  def home
  end
end
