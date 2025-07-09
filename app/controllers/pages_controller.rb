class PagesController < ApplicationController
  # PAS d'authenticate_user! - pages publiques

  def home
    @featured_gardens = Garden.limit(3) # Aperçu jardins pour donner envie
  end

  def confidentiality;
  end

  def terms;
  end

  def sitemap;
  end

  def how_it_works;
  end

  def about_us;
  end
end
