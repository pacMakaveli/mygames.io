class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!, only: [:index]

  def index
    @games = current_user.games
    @wishlist = Wishlist.where(user_id: current_user)

    render 'application/dashboard'
  end
end
