class BookingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookings = current_user.bookings.includes(:garden)
  end

  def create
    @garden = Garden.find(params[:garden_id])
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.garden = @garden
    @booking.status = :pending

    if @booking.save
      redirect_to bookings_path, notice: 'Réservation créée avec succès!'
    else
      redirect_to @garden, alert: 'Erreur lors de la réservation.'
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :price_per_day)
  end
end
