class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  include Pundit::Authorization

  # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end

  private

  def configure_permitted_parameters
    # Paramètres autorisés pour l'inscription
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])

    # Paramètres autorisés pour la mise à jour du compte
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :avatar])
  end
end
