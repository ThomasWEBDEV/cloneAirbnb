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
      @booking.update(
        status: :pending,
        start_date: Date.parse(booking_params[:start_date]),
        end_date: Date.parse(booking_params[:end_date])
      )

      redirect_to bookings_path, notice: 'Votre réservation a été envoyée au propriétaire pour confirmation !'
    else
      redirect_to @garden, alert: 'Erreur lors de la réservation.'
    end
  end

  def show
    @booking = Booking.find(params[:id])
    authorize_booking!
  end

  def confirm
    @booking = Booking.find(params[:id])

    if @booking.garden.user == current_user
      @booking.update(status: "confirmed")
      Notification.create!(
        user: @booking.user,
        booking: @booking,
        message: "Votre réservation pour #{@booking.garden.title} a été confirmée !",
        read: false
        )

      flash[:notice] = "Réservation confirmée et nous avons informé votre client!"
    else
      flash[:alert] = "Vous n'avez pas le droit de confirmer cette réservation."
    end

    redirect_to notifications_path
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :price_per_day)
  end

  def authorize_booking!
    unless @booking.garden.user == current_user || @booking.user == current_user
      redirect_to root_path, alert: "Access denied."
    end
  end
end
