class PagesController < ApplicationController
  # PAS d'authenticate_user! - pages publiques

  def home
    @featured_gardens = Garden.limit(3) # Aperçu jardins pour donner envie
  end
end
