class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_stripe_key

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:country, :email, :password)}

      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:country, :email, :password, :current_password)}
 
    end

  private

    def set_stripe_key
      Stripe.api_key = ENV['api_key']
    end
end
