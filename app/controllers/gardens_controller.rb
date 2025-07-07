class GardensController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_garden, only: [:show, :edit, :update, :destroy]
  # Vérifications Pundit manuelles pour ce contrôleur seulement
  after_action :verify_authorized, except: [:index]
  after_action :verify_policy_scoped, only: [:index]
  def index
  @gardens = Garden.all

  if params[:query].present? || params[:location].present?
    search_string = [params[:query], params[:location]].compact.join(" ")
    @gardens = @gardens.garden_search(search_string)
  end

  @gardens = policy_scope(@gardens)

  # Filtrage par dates de disponibilité
  if params[:start_date].present? && params[:end_date].present?
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])
    @gardens = @gardens.select do |garden|
      garden.bookings.none? do |booking|
        booking_start = booking.start_date
        booking_end = booking.end_date
        (start_date <= booking_end) && (end_date >= booking_start)
      end
    end
  end

  # Marqueurs Mapbox - UNE SEULE fois
  @markers = @gardens.geocoded.map do |garden|
    {
      lat: garden.latitude,
      lng: garden.longitude
    }
  end
end
  def show
    authorize @garden
    # @garden déjà défini par set_garden
    @marker = [{
      lat: @garden.latitude,
      lng: @garden.longitude
    }] if @garden.geocoded?
  end
  def new
    @garden = Garden.new
    authorize @garden
  end
  def create
    @garden = Garden.new(garden_params)
    @garden.user = current_user
    authorize @garden
    if @garden.save
      redirect_to @garden, notice: 'Jardin créé avec succès!'
    else
      render :new
    end
  end
  def edit
    authorize @garden
    # @garden déjà défini par set_garden
  end
  def update
    authorize @garden
    if @garden.update(garden_params)
      redirect_to @garden, notice: 'Jardin mis à jour!'
    else
      render :edit
    end
  end
  def destroy
    authorize @garden
    @garden.destroy
    redirect_to gardens_path, notice: 'Jardin supprimé!'
  end
  private
  def set_garden
    @garden = Garden.find(params[:id])
  end
  def garden_params
    params.require(:garden).permit(:title, :description, :address, :price_per_day, photos: [])
  end
end