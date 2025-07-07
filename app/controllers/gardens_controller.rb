class GardensController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_garden, only: [:show, :edit, :update, :destroy]

  def index
    if params[:query].present?
      @gardens = Garden.garden_search(params[:query])
    else
      @gardens = Garden.all
    end

    @markers = @gardens.geocoded.map do |garden|
      {
        lat: garden.latitude,
        lng: garden.longitude
      }
    end

    # initialisation de la carte avec Mapbox
    @markers = @gardens.geocoded.map do |garden|
      {
        lat: garden.latitude,
        lng: garden.longitude,
      }
    end
  end

  def show
    # @garden déjà défini par set_garden
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
    # @garden déjà défini par set_garden
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
