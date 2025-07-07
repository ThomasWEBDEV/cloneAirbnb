class GardensController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_garden, only: [:show, :edit, :update, :destroy]

  def index
    @gardens = Garden.all

    # Recherche par mot-clé et localisation
    if params[:query].present? || params[:location].present?
      search_string = [params[:query], params[:location]].compact.join(" ")
      @gardens = @gardens.garden_search(search_string)
    end

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

    # Marqueurs Mapbox — corrigé pour éviter l’erreur sur Array
    @markers = @gardens.map do |garden|
      if garden.latitude && garden.longitude
        {
          lat: garden.latitude,
          lng: garden.longitude
        }
      end
    end.compact
  end

  def show
    @marker = [{
      lat: @garden.latitude,
      lng: @garden.longitude
    }] if @garden.geocoded?
  end

  def new
    @garden = Garden.new
  end

  def create
    @garden = Garden.new(garden_params)
    @garden.user = current_user

    if @garden.save
      redirect_to @garden, notice: 'Jardin créé avec succès!'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @garden.update(garden_params)
      redirect_to @garden, notice: 'Jardin mis à jour!'
    else
      render :edit
    end
  end

  def destroy
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
