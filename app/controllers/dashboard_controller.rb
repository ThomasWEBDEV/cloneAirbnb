class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @my_gardens = current_user.gardens
    @my_bookings = current_user.bookings.includes(:garden)
  end
end
